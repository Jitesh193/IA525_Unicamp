def dotprod(x, y, xp, yp, n):
    """"
    Funcao que verifica se o ponto esta dentro ou nao
    x: vertices 'x' do poligono
    y: vertices 'y' do poligono
    xp: vertice 'x' do ponto que se deseja avaliar
    yp: vertice 'y' do ponto que se deseja avaliar
    n: numero de vertices do poligono
    """

    dpos = 0
    dneg = 0
    dentro = False

    x0 = x[0]
    y0 = y[0]

    for i in range(1, n + 1):

        if i == n:
            x1 = x[0]
            y1 = y[0]
        else:
            x1 = x[i]
            y1 = y[i]

        dprod = (xp - x0)*(y1 - y0) - (yp - y0)*(x1 - x0)   # Produto interno entre o vetor vertice-ponto e o vetor
                                                            # normal da reta formada pelos vertices do poligono

        if dprod > 0:
            dpos += 1
        elif dprod == 0:
            dpos += 1
        else:
            dneg += 1

        x0 = x1
        y0 = y1

    if dpos > 0 and dneg == 0:
        dentro = True
    elif dneg > 0:
        dentro = False


    return dentro