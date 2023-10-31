:- consult('TDA_Option.pl').
%Constructor:
%predicado: flow(Id, Name-msg, Option, Flow).
%Dominio:
% Id: id (Int)
% Name-msg: name-msg (String)
% Option: Options (lista de 0 o m�s Options)
% Flow: Flow
%Meta principal: crear un TDA Flow
flow(Id, Nmsg, Ops, [Id, Nmsg, Ops1]):- integer(Id), string(Nmsg),
    filter_Option_list(Ops, Ops1), !.

%Selector:
%predicado: get_flow_Options(F, Ops).
%Dominio:
%F: Flow
%Ops: lista de Options
get_flow_Options(F, Ops):- flow(_,_,Ops, F).

%Selector:
%predicado: get_flow_id(F, Id).
%Dominio:
%F: Flow
%Id: id (int)
get_flow_id(F, Id):- flow(Id,_,_, F).

%Selector:
%predicado: get_flow_name_msg(F, Nmsg).
%Dominio:
%F: Flow
%Nmsg: name-msg (String)
get_flow_name_msg(F, Nmsg):- flow(_,Nmsg,_, F).

%Otros:
%predicado: filter_Option_list(L1, L2).
%Dominio:
% L1: lista de Options
% L2: Lista de Options
%Meta principal: filtrar una lista de opciones en base al code para que
% no aparezcan opciones repetidas.
%Tipo de Recursi�n: de cola.
filter_Option_list_aux([], R, R1):- reverse(R, R1).
filter_Option_list_aux([H|T], L, R):- not(option_member_list(H, L)),
    filter_Option_list_aux(T, [H|L], R).
filter_Option_list_aux([H|T], L, R):- option_member_list(H, L),
    filter_Option_list_aux(T, L, R).
filter_Option_list(L1, L2):- filter_Option_list_aux(L1, [], L2), !.

%predicado: option_member_flow(O, F).
%Dominio:
%O: option
%L: F
option_member_flow(O, F):- get_flow_Options(F, Ops),
    option_member_list(O, Ops).
