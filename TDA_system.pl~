:- consult('TDA_Chatbot.pl').

%Constructor:
%predicado: system(Name, InitialChatbotCodeLink, Chatbots, System).
%Dominio:
%!  Name: name (string)
%!  InitialChatbotCodeLink: InitialChatbotCodeLink (int)
%!  Chatbots: lista de chatbots
%!  System: system
%Meta principal: construir un sistema de chatbots
system(N, ICCL, Cs, [N, ICCL, Cs1, [], "", -1, -1]):-
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

%Modificador:
%predicado: systemAddChatbot(SystemIn, Chatbot, SystemOut).
%Dominio:
%!  SystemIn: system
%!  Chatbot: chatbot
%!  SystemOut: system
%Meta principal: añadir un chatbot sin repetir a un sistema
systemAddChatbot(Sin, C, [N, I, [C|Cs], U, CH, ActCId, ActFId]):-
    get_system_chatbots(Sin, Cs),
    not(chatbot_member_list(C, Cs)),
    get_system_name(Sin, N),
    get_system_InitialChatbotCodeLink(Sin, I),
    get_system_users(Sin, U),
    get_system_chatHistory(Sin, CH),
    get_system_actCId(Sin, ActCId),
    get_system_actFId(Sin, ActFId), !.
systemAddChatbot(S, C, S):- get_system_chatbots(S, Cs),
    chatbot_member_list(C, Cs), !.

%Selector:
%predicado: get_system_name(S, N).
%Dominio:
%!  S: system
%!  N: name (string)
%Meta principal: obtener el nombre de un sistema dado
get_system_name([N,_,_,_,_,_,_], N).

%Selector:
%predicado: get_system_InitialChatbotCodeLink(S, I).
%Dominio:
%!  S: system
%!  I: InitialChatbotCodeLink
%Meta principal: obtener la id inicial de un chatbot de un sistema dado
get_system_InitialChatbotCodeLink([_,I,_,_,_,_,_], I).

%Selector:
%predicado: get_system_chatbots(S, Cs).
%Dominio:
%!  S: system
%!  Cs: lista de 0 o más chatbots
%Meta principal: obtener los chatbots de un sistema dado
get_system_chatbots([_,_,Cs,_,_,_,_], Cs).

%Selector:
%predicado: get_system_users(S, U).
%Dominio:
%!  S: system
%!  U: lista de 0 o más users
%Meta principal: obtener los usuarios que hay en un sistema dado
get_system_users([_,_,_,U,_,_,_], U).

%Selector:
%predicado: get_system_chatHistory(S, CH).
%Dominio:
%!  S: system
%!  CH: chatHistory
%Meta principal: obtener el historial de chat de un sistema dado
get_system_chatHistory([_,_,_,_,CH,_,_], CH).

%Selector:
%predicado: get_system_actCId(S, ActCId).
%Dominio:
%!  S: system
%!  ActCId: actCId
%Meta principal: obtener la id del chatbot actual de la conversación de
% un sistema dado
get_system_actCId([_,_,_,_,_,ActCId,_],ActCId).

%Selector:
%predicado: get_system_actFId(S, ActFId).
%Dominio:
%!  S: system
%!  ActCId: actFId
%Meta principal: obtener la id del flow actual de la conversación de un
% sistema dado
 get_system_actFId([_,_,_,_,_,_,ActFId], ActFId).

%Modificador:
%predicado: systemAddUser(Sin, U, Sout).
%Dominio:
%!  Sin: system
%!  U: user
%!  Sout: system
%Meta principal: Agregar un usuario dado a un sistema dado sin que se
% repita
systemAddUser(S, U, S):- get_system_users(S, Users),
    user_member_list(U, Users), !.
systemAddUser(Sin, U, [N, I, Cs, [U|Users], CH, ActCId, ActFId]):-
    get_system_users(Sin, Users),
    not(user_member_list(U, Users)),
    get_system_name(Sin, N),
    get_system_InitialChatbotCodeLink(Sin, I),
    get_system_chatbots(Sin, Cs),
    get_system_chatHistory(Sin, CH),
    get_system_actCId(Sin, ActCId),
    get_system_actFId(Sin, ActFId), !.

%Verificador:
%predicado: user_member_list(U, Users).
%Dominio:
%!  U: user
%!  Users: lista de 0 o más usuarios
%Meta principal: Verificar si un usuario está en una lista de usuarios
user_member_list(U, Users):- member(U, Users).
