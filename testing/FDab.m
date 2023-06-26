function  qdd = FDab(model, q, qd, tau)
    a_grav = [0,0,0,0,0,-9.81];
    a_grav = a_grav';
    
    for i = 1:model.NB
      [ XJ, S{i} ] = jcalc( model.jtype{i}, q(i) );
      vJ = S{i}*qd(i);
      Xup{i} = XJ * model.Xtree{i};
      if model.parent(i) == 0
        v{i} = vJ;
        c{i} = zeros(size(a_grav));		% spatial or planar zero vector
      else
        v{i} = Xup{i}*v{model.parent(i)} + vJ;
        c{i} = crm(v{i}) * vJ;
      end
      IA{i} = model.I{i};
      pA{i} = crf(v{i}) * model.I{i} * v{i};
    end
    
    for i = model.NB:-1:1
      U{i} = IA{i} * S{i};
      d{i} = S{i}' * U{i};
      u{i} = tau(i) - S{i}'*pA{i};
      if model.parent(i) ~= 0
        Ia = IA{i} - U{i}*U{i}'/d{i};
        pa = pA{i} + Ia*c{i} + U{i} * u{i}/d{i};
        IA{model.parent(i)} = IA{model.parent(i)} + Xup{i}' * Ia * Xup{i};
        pA{model.parent(i)} = pA{model.parent(i)} + Xup{i}' * pa;
      end
    end
    
    for i = 1:model.NB
      if model.parent(i) == 0
        a{i} = Xup{i} * -a_grav + c{i};
      else
        a{i} = Xup{i} * a{model.parent(i)} + c{i};
      end
      qdd(i) = (u{i} - U{i}'*a{i})/d{i};
      a{i} = a{i} + S{i}*qdd(i);
    end