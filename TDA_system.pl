:- consult('TDA_Chatbot.pl').

%Constructor:
%predicado: system(Name, InitialChatbotCodeLink, Chatbots, System).
%Dominio:
%!  Name: name (string)
%!  InitialChatbotCodeLink: InitialChatbotCodeLink (int)
%!  Chatbots: lista de chatbots
%!  System: system
%Meta principal: construir un sistema de chatbots
system(N, ICCL, Cs, [N, ICCL, Cs1, [], [], -1, -1]):-
    string(N), integer(ICCL), filter_chatbots_list(Cs, Cs1).

%Modificador:
%predicado: filter_chatbots_list(CsIn, CsOut).
%Dominio:
%!  CsIn: lista de 0 o más chatbots
%!  CsOut: lista de 0 o más chatbots
%Meta principal: filtrar por la id una lista de chatbots
%Tipo de recursión: de Cola
filter_chatbots_list_aux([], R, R1):- reverse(R, R1).
filter_chatbots_list_aux([H|T], L, R):- not(chatbot_member_list(H, L)),
    filter_chatbots_list_aux(T, [H|L], R).
filter_chatbots_list_aux([H|T], L, R):- chatbot_member_list(H, L),

    filter_chatbots_list_aux(T, L, R).
filter_chatbots_list(ChatbotsIn, ChatbotsOut):-
    filter_chatbots_list_aux(ChatbotsIn, [], ChatbotsOut), !.

%Verificador:
%predicado: chatbot_member_list(C, L).
%Dominio:
%!  C: chatbot
%!  L: lista de 0 o más chatbots
%Meta principal: averiguar en base a la id si un chatbot pertenece a
% una lista
%Tipo de recursión: de Cola
chatbot_member_list(C, [H|_]):- get_chatbot_chatbotID(C, Id1),
    get_chatbot_chatbotID(H, Id2), Id1 = Id2.
chatbot_member_list(C, [_|T]):- chatbot_member_list(C, T), !.
