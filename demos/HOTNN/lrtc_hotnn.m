function [X_hat] = lrtc_hotnn(X_incomplete, omega)
	
	mu = 1e-4;
	tol = 1e-8; 
	rho = 1.1;
	max_iter = 500;
	max_mu = 1e10;
    DEBUG = 1;

	assert(ndims(X_incomplete) == 5);
	L = zeros(size(X_incomplete));
    L(omega)=X_incomplete(omega);
	S = zeros(size(X_incomplete));
	Y = zeros(size(X_incomplete));

	for iter = 1 : max_iter
 	
        Lk = L;
  		Sk = S;
  		
    	%update L
    	tau = 1 / mu;
    	B = X_incomplete - S +(Y / mu);
    	[L,tnnx] = proximal_optimize_change_tracks(B, tau);
        
        %update S
    	S = X_incomplete - L +(Y / mu);
    	S(omega)=0;
        
        dY=X_incomplete-L-S;
        dL = max(abs(L(:) - Lk(:)));
    	dS = max(abs(S(:) - Sk(:)));
    	chg = max( [dL, dS, max(abs(dY(:)))]);
       
        if DEBUG 
            if iter == 1 || mod(iter, 10) == 0
                err=norm(dY(:));
                obj=tnnx;
                disp(['iter ' num2str(iter) ', mu=' num2str(mu) ...
                     ', obj=' num2str(obj)  ', err=' num2str(err)]); 
            end
        end
        
        if chg < tol
    		break;
        end	
        
 	   	Y = Y + mu * dY;
    	mu = min(rho * mu, max_mu);   
        
    end
    X_hat = L;
    disp('the numer of iterations:');
    disp(iter);

