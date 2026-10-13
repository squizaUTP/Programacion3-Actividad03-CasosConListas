
% ==============================================================================
% EJERCICIO 1 -Familia Simpson con listas
% ==============================================================================

% HECHOS

padre(abraham, [homero, herbert]).
padre(clancy, [marge, patty, selma]).
padre(homero, [bart, lisa, maggie]).

madre(mona, [homero, herbert]).
madre(jacqueline, [marge, patty, selma]).
madre(marge, [bart, lisa, maggie]).
madre(selma, [ling]).


%Reglas

progenitor(X, Y) :- 
    padre(X, Hijos), 
    member(Y, Hijos).

progenitor(X, Y) :- 
    madre(X, Hijos), 
    member(Y, Hijos).

abuelo(A, N) :-
    padre(A, HijosDeA),
    member(P, HijosDeA),
    progenitor(P, N).


abuela(A, N) :-
    madre(A, HijosDeA),
    member(P, HijosDeA),
    progenitor(P, N).

hijos_de(Persona, Lista) :- padre(Persona, Lista).
hijos_de(Persona, Lista) :- madre(Persona, Lista).

nietos_de(Abuelo, ListaNietos) :-
    findall(N, abuelo(Abuelo, N), ListaNietos).


%pruebas
%?- hijos_de(marge, Lista).
%?- nietos_de(abraham, Lista).





%---------------------------------------------------------------------------------------



% ==============================================================================
% EJERCICIO 2 - Grafo dirigido de Canadá con listas
% ==============================================================================

% --- HECHOS ---
ruta(vancouver, edmonton, 16).
ruta(vancouver, calgary, 13).
ruta(edmonton, saskatoon, 12).
ruta(calgary, regina, 14).
ruta(calgary, edmonton, 4).
ruta(saskatoon, calgary, 9).
ruta(saskatoon, winnipeg, 20).
ruta(regina, saskatoon, 7).
ruta(regina, winnipeg, 4).


% --- REGLAS ---

% Determinar si un nodo tiene aristas
tiene_aristas(Nodo) :- ruta(Nodo, _, _), !.
tiene_aristas(Nodo) :- ruta(_, Nodo, _), !.

% Costo para ir de un nodo X a un Z pasando por Y
costo_pasando_por(X, Y, Z, CostoTotal) :-
    ruta(X, Y, C1),
    ruta(Y, Z, C2),
    CostoTotal is C1 + C2.


% --- CONSTRUCCIÓN DE RUTAS CON LISTAS (Pregunta más interesante) ---


camino(X, Y, [X, Y], Costo) :-
    ruta(X, Y, Costo).

% Caso Recursivo: No hay conexión directa, busca un nodo intermedio Z
camino(X, Y, [X | Resto], CostoTotal) :-
    ruta(X, Z, C1),
    camino(Z, Y, Resto, C2),
    CostoTotal is C1 + C2.


% --- Reglas aux


% Lista de conexiones con sus costos desde una ciudad
conexiones_desde(Origen, ListaConexiones) :-
    findall(Destino-Costo, ruta(Origen, Destino, Costo), ListaConexiones).







