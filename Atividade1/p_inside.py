def dotprod(x, y, xp, yp, n):
    """"
    Funcao que verifica se o ponto esta dentro ou nao
    x: vertices 'x' do poligono
    y: vertices 'y' do poligono
    xp: vertice 'x' do ponto que se deseja avaliar
    yp: vertice 'y' do ponto que se deseja avaliar
    n: numero de vertices do poligono
    """
    # Inicializacao das variaveis
    dpos = 0
    dneg = 0
    dentro = False

    x0 = x[0]
    y0 = y[0]

    # Avaliacao para ver se o ponto esta dentro ou nao do poligono
    for i in range(1, n + 1):

        # Caso esteja no ultimo ponto, a proxima aresta a ser avaliada eh a que liga o ultimo com o primeiro vertice
        if i == n:
            x1 = x[0]
            y1 = y[0]
        # Caso contrario, a aresta eh o ponto atual (x0,y0) com o proximo ponto da ordem (x1,y1)
        else:
            x1 = x[i]
            y1 = y[i]

        dprod = (xp - x0)*(y1 - y0) - (yp - y0)*(x1 - x0)   # Produto interno entre o vetor vertice-ponto e o vetor
                                                            # normal da reta formada pelos vertices do poligono

        # Caso o produto interno >= 0 -> o vetor vertice-ponto esta na mesma direcao do vetor normal da aresta
        if dprod > 0:
            dpos += 1
        elif dprod == 0:
            dpos += 1

        # Caso contrario, o vetor vertice-ponto esta no lado oposto do vetor normal da aresta
        else:
            dneg += 1

        x0 = x1
        y0 = y1

    # Se houver algum ponto que esta na direcao oposta do vetor normal da aresta (dneg > 0), isso indica que o
    # ponto esta fora do poligono, logo a variavel "dentro" eh False. Caso contrario, isto eh, "dneg == 0" indica que o
    # ponto esta dentro do poligono e a variavel "dentro" eh True
    if dpos > 0 and dneg == 0:
        dentro = True
    elif dneg > 0:
        dentro = False

    return dentro
