#  Página 97 (Projetos de Implementação) -> itens 6.1, 6.2-c, 6.2-e 

* 6.1 implemente o algoritmo proposto na Seção 6.1.2 em assembly.
* 6.2 implemente as seguintes variações:
    * c) minimize o número de chamadas ao serviço brk alocando espaços múltiplos de 4096 bytes por vez. Se for solicitado um espaço maior, digamos 5000 bytes, então será alocado um espaço de 4096 ∗ 2 = 8192 bytes para acomodá-lo.
    * e) escreva variações do algoritmo de escolha dos nós livres:
        * first fit: percorre a lista do início e escolhe o primeiro nó com tamanho maior ou igual ao solicitado;
        * best fit: percorre toda a lista e seleciona o nó com menor bloco, que é maior do que o solicitado;
        * next fit: é first fit em uma lista circular. A busca começa onde a última parou