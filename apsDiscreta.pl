% Predicado: F(x) (x é um funcionário)
f(yuri). 
f(vinicius). 
f(carlos). 
f(mateus). 

% Predicado: C(x, y) ( O funcionário x ocupa o cargo y)
c(yuri, gerente). 
c(vinicius, desenvolvedor). 
c(carlos, desenvolvedor). 
c(mateus, gerente). 

% Predicado: Proj(x) (x é um projeto) 
proj(fastTracker). 
proj(charlieProject). 

% Predicado: P(x) (x é um produto final) 
p(crm). 
p(microSaaS). 

% Predicado: G(x, y) (O funcionário x gerencia o projeto y)
g(yuri, fastTracker). 
g(mateus, charlieProject). 

% Predicado: T(x, y) (O funcionário x trabalha no projeto y)
t(yuri, fastTracker). 
t(mateus, charlieProject). 
t(vinicius, fastTracker). 
t(carlos, fastTracker). 
t(carlos, charlieProject). 

% Predicado: D(x, y) (O projeto x desenvolve o produto y)
d(fastTracker, crm). 
d(charlieProject, microSaaS).

% Fórmula 2: Somente funcionários podem gerenciar projetos 
% ∀x ∀y (G(x, y) → F(x)) 
f(X) :- g(X, _Y). 

% (Se X gerencia algo, X é um funcionário) 
f(X) :- g(X, _). 

% Fórmula 6: Todo gerente trabalha no projeto que gerencia 
% ∀x ∀y (G(x, y) → T(x, y)) 
t(X, Y) :- g(X, Y).
 
% Fórmula 7: Se alguém trabalha em um projeto que desenvolve um produto, 
% essa pessoa é responsável (parcialmente) por esse produto. 
% ∀x∀y∀z (T(x, y) ⋀ D(y, z) → R(x, z)) 
r(X, Z) :- t(X, Y), d(Y, Z). 

% Fórmula 10: Apenas quem tem cargo é considerado funcionário 
% ∀x (F(x) ⇿ (∃y C(x, y))) 
f(X) :- c(X, _). 

% Consultas: 

% 1. O vinicius é desenvolvedor? 
?- c(vinicius, desenvolvedor). 
% R: true. 

% 2. (Inferência com Regra 6) O yuri trabalha no FastTracker? 
% (Isso é um fato, mas também é inferido pela regra 6) 
?- t(yuri, fastTracker). 
% R: true. 

% 3. (Inferência com Regra 7) O vinicius é responsável pelo CRM? 
% (Ele T(vinicius, fastTracker) e D(fastTracker, crm) -> R(vinicius, crm)) 
?- r(vinicius, crm). 
% R: true. 

% 4. (Inferência com Regra 7) Quem é responsável pelo microSaaS? 
% (Prolog buscará quem T(X, Y) e D(Y, microSaaS)) 
?- r(X, microSaaS). 
% R: X = mateus ; 
% R: X = carlos. 

% 5. (Consulta com variável) Quais projetos o carlos trabalha? 
?- t(carlos, Y). 
% R: Y = fastTracker ; 
% R: Y = charlieProject.
