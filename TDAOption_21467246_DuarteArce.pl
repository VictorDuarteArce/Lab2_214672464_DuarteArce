%Verificador
%predicado: is_Keyword(Keyword).
%Dominio:
% Keyword: cualquier cosa
%Meta principal: verificar que la lista keyword sea de solo strings
%Tipo de recursi�n: de cola
is_Keyword([]).
is_Keyword([H|T]):- string(H), is_Keyword(T).

%Constructor:
%predicado: option(Code, Message, ChatbotCodeLink, InitialFlowCodeLink,
% Keyword, Option).
%Dominio:
% Code: code (Int)
% Message: message (String)
% ChatbotCodeLink: ChatbotCodeLink (Int)
% InitialFlowCodeLink: InitialFlowCodeLink (Int)
% Keyword: Keyword (lista de 0 o m�s palabras)
% Option: option
%Meta principal: Construir el TDA Option
option(C, M, CbCL, IFCL, K, [C, M, CbCL, IFCL, K]):-
    integer(C), string(M), integer(CbCL), integer(IFCL), is_Keyword(K).

%Selectores:
%predicado: get_Option_code(O, C).
%Dominio:
% O: Option
% C: code (int)
%Meta principal: obtener el code de un option.
get_Option_code(O, C):- option(C,_,_,_,_,O).


%Otros:
%predicado: option_member_list(O, L).
%Dominio:
%O: option
%L: Lista de options
%Meta principal: verificar si una opci�n pertenece a una lista de
% options
option_member_list(O, [H|_]):-
    get_Option_code(H, C1), get_Option_code(O, C2), C1 = C2.
option_member_list(O, [_|T]):- option_member_list(O, T).

%Otro:
%predicado: option_string(O, Str).
%Dominio:
%!  O: option
%!  Str: string
%Meta principal: obtener el string de un option
option_string(O, Str):- get_Option_message(O, Str1), concat(Str1, "\n", Str).

%Otro:
%predicado: options_string
%predicado: options_string(Ops, Str).
%Dominio:
%!  Ops: lista de 0 o m�s opciones
%!  Str: string
%Meta principal: obtener el string de un flow
options_string([], "").
options_string([H|T], StrOps):- option_string(H, StrOp),
     options_string(T, StrOpsT), concat(StrOp, StrOpsT, StrOps).

%Selector:
%predicado: get_Option_message(O, M).
%Dominio:
%!  O: option
%!  M: message
%Meta principal: obtener el mensaje de una opci�n dada.
get_Option_message(O, M):- option(_,M,_,_,_,O).

%Selector:
%predicado: get_Option_chatbotCodeLink(O, CCL).
%Dominio:
%!  O: option
%!  CCL: chatbotCodeLink (int)
%Meta principal: obtener el chatbotCodeLink de una opci�n dada.
get_Option_chatbotCodeLink(O, CCL):- option(_,_,CCL,_,_,O).

%Selector:
%predicado: get_Option_InitialflowCodeLink(O, IFCL).
%Dominio:
%!  O: option
%!  IFCL: InitialflowCodeLink (int)
%Meta principal: obtener el chatbotCodeLink de una opci�n dada.
get_Option_InitialflowCodeLink(O, IFCL):- option(_,_,_,IFCL,_,O).

%Selector:
%predicado: get_Option_keywords(O, Keys).
%Dominio:
%!  O: option
%!  Keys: keywords
%Meta principal: obtener el chatbotCodeLink de una opci�n dada.
get_Option_keywords(O, Keys):- option(_,_,_,_,Keys,O).

%Otro:
%predicado: member_keyword(Key, Keys).
%Dominio:
%!  Key: keyword
%!  Keys: lista de 0 o m�s keywords
%Meta principal: verificar si una keyword pertenece a una lista de
% keywords
member_keyword(Key, [Key|_]).
member_keyword(Key, [_|T]):- member_keyword(Key, T).
