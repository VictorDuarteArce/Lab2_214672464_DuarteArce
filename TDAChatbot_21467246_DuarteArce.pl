:- consult('TDAFlow_21467246_DuarteArce.pl').

%Constructor:
%predicado: chatbot(ChabotID, Name, WelcomeMessage, StartFlowId,
                    %Flows, Chatbot).
%Dominio:
% ChatbotID: chatbotID (int)
% Name: name (string)
% WelcomeMessage: welcomeMessage (string)
% StartFlowId: startFlowId (int)
% Flows: lista de 0 o m�s flows
% Chatbot: chatbot
chatbot(CID, Name, WcmMsg, StFId, Flows,
        [CID, Name, WcmMsg, StFId, Flows1]):-
    integer(CID), string(Name), string(WcmMsg),
    integer(StFId), filter_flows_list(Flows, Flows1).
%Modificador:
%predicado: filter_flows_list(FlowsIn, FlowsOut).
%Dominio:
%FlowsIn: lista de 0 o m�s Flows
%FlowsOut: lista de 0 o m�s Flows
%Tipo de recursi�n: de Cola
filter_flows_list_aux([], R, R1):- reverse(R, R1).
filter_flows_list_aux([H|T], L, R):- not(flow_member_list(H, L)),
    filter_flows_list_aux(T, [H|L], R).
filter_flows_list_aux([H|T], L, R):- flow_member_list(H, L),
    filter_flows_list_aux(T, L, R).
filter_flows_list(FlowsIn, FlowsOut):-
    filter_flows_list_aux(FlowsIn, [], FlowsOut), !.

%Verificador:
%predicado: flow_member_list(Flow, List).
%Dominio:
% Flow: flow
% List: lista de 0 o m�s flows
%Tipo de recursi�n: de Cola
flow_member_list(F, [H|_]):- get_flow_id(F, Id1),
    get_flow_id(H, Id2), Id1 = Id2.
flow_member_list(F, [_|T]):- flow_member_list(F, T), !.

%Selector:
%predicado: get_chatbot_flows(Chatbot, Flows).
%Dominio:
% Chatbot: chatbot
% Flows: lista de 0 o m�s flows
%Meta principal: obtener la lista de flows de un chatbot
get_chatbot_flows(Chatbot, Flows):-
    chatbot(_,_,_,_,Flows, Chatbot).

%Selector:
%predicado: get_chatbot_chatbotID(Chatbot, ChatbotID).
%Dominio:
% Chatbot: chatbot
% ChatbotID: chatbotID
%Meta principal: obtener la id de un chatbot dado
get_chatbot_chatbotID(C, CID):- chatbot(CID,_,_,_,_, C).

%Selector:
%predicado: get_chatbot_name(Chabot, Name).
%Dominio:
% Chatbot: chatbot
% Name: name
%Meta principal: obtener el nombre de un chatbot dado
get_chatbot_name(C, N):- chatbot(_,N,_,_,_, C).

%Selector:
%predicado: get_chatbot_welcomeMessage(Chatbot, WcMsg).
%Dominio:
% Chatbot: chatbot
% WcMsg: welcomeMessage
%Meta principal: obtener el welcomeMessage de un chatbot dado
get_chatbot_welcomeMessage(C, W):- chatbot(_,_,W,_,_, C).

%Selector:
%predicado: get_chatbot_startFlowId(Chatbot, StFId).
%Dominio:
% Chatbot: chatbot
% StFId: startFlowId
%Meta principal: obtener el startFlowId de un chatbot dado
get_chatbot_startFlowId(C, S):- chatbot(_,_,_,S,_, C).

%Modificador:
%predicado: chatbotAddFlow(ChatbotIn, Flow, ChatbotOut).
%Dominio:
% ChatbotIn: chatbot
% Flow: flow
% ChatbotOut: chatbot
%Tipo de recursi�n: Natural
%Meta principal: agregar un flow al final de la lista de flows
%del chatbot sin que se repitan, en caso contrario, dejar igual
%la estructura.
chatbotAddFlow(C, F, C):- get_chatbot_flows(C, Fls),
    flow_member_list(F, Fls), !.
chatbotAddFlow(Cin, F, Cout):-
    get_chatbot_flows(Cin, FlsIn),
    not(flow_member_list(F, FlsIn)),
    insertar_flow_fin(F, FlsIn, FlsOut),
    get_chatbot_chatbotID(Cin, ID),
    get_chatbot_name(Cin, N),
    get_chatbot_welcomeMessage(Cin, W),
    get_chatbot_startFlowId(Cin, S),
    chatbot(ID, N, W, S, FlsOut, Cout), !.

%Otros:
%predicado: insertar_flow_fin(Flow, FlowsIn, FlowsOut).
%Dominio:
% Flow: flow
% FlowsIn: lista de 0 o m�s flows
% FlowsOut: lista de 1 o m�s flows
%Tipo de recursi�n: Natural
%Meta principal: agregar un flow al final de una lista de flows
insertar_flow_fin(F, [], [F]).
insertar_flow_fin(F, [H|T], [H|R]):- insertar_flow_fin(F, T, R).

%Otro:
%predicado: chatbot_flow_string(C, Fid, Str).
%Dominio:
%!  C: chatbot
%!  Fid: id de un flow (int)
%!  Str: string
%Meta principal: obtener el string del flow de un chatbot dado
% a partir de su id
chatbot_flow_string(C, Fid, Str):-
    get_chatbot_flows(C, Fs),
    chosen_flow(Fs, Fid, F),
    flow_string(F, StrF1),
    get_chatbot_name(C, N),
    concat(N, " ", Str0),
    concat(Str0, "", Str1),
    concat(Str1, " \n", Str2),
    concat(Str2, StrF1, Str), !.
%Otro:
%predicado: chosen_flow(Fs, Id, F).
%Dominio:
%!  Fs: lista de 0 o m�s flows
%!  Id: id de un flow
%!  F: flow
%Meta principal: escoger un flow de una lista dada a partir de
% su id
chosen_flow([H|_], Id, H):- get_flow_id(H, Id).
chosen_flow([_|T], Id, R):- chosen_flow(T, Id, R).
