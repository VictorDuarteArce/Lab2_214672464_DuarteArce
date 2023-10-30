%Verificador
%predicado: is_Keyword(Keyword).
%Dominio:
% Keyword: cualquier cosa
%Meta principal: verificar que la lista keyword sea de solo strings
%Tipo de recursión: de cola
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
% Keyword: Keyword (lista de 0 o más palabras)
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
