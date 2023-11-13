:- consult('TDAOption_214672464_DuarteArce.pl').
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

% Modificador:
% predicado: flowAddOption(F1, O, F2).
% Dominio:
% F1: flow
% O: option
% F2: flow
% Meta principal: agregar una opci�n sin repetir a un flow.
flowAddOption(F1, O, F2):-
    not(option_member_flow(O, F1)),
    get_flow_id(F1, Id),
    get_flow_name_msg(F1, Nmsg),
    get_flow_Options(F1, Ops),
    flow(Id, Nmsg, [O|Ops], F2), !.
flowAddOption(F1, O, F2):-
    option_member_flow(O, F1),
    get_flow_id(F1, Id),
    get_flow_name_msg(F1, Nmsg),
    get_flow_Options(F1, Ops),
    flow(Id, Nmsg, Ops, F2), !.

%Otro:
%predicado: flow_string(F, Str).
%Dominio:
%!  F: flow
%!  Str: string
flow_string(F, Str):- get_flow_Options(F, Ops),
    get_flow_name_msg(F, Msg1),
    options_string(Ops, StrOps),
    concat(Msg1, "\n", Msg2),
    concat(Msg2, StrOps, Str).

