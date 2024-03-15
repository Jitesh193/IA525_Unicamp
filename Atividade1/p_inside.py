def p_inside(x, y, xp, yp, n):
    """"
    Funcao que verifica se o ponto esta dentro ou nao
    x: vertices 'x' do poligono
    y: vertices 'y' do poligono
    xp: vertice 'x' do ponto que se deseja avaliar
    yp: vertice 'y' do ponto que se deseja avaliar
    n: numero de vertices do poligono
    """

    d = 0

    x0 = x[0]
    y0 = y[0]

    for i in range(1, n + 1):

        if i == n:
            # Esta dando problema aqui quando a reta eh paralela ao y
            x1 = x[0]
            y1 = y[0]
        else:
            x1 = x[i]
            y1 = y[i]

        # equacao da reta - coeficiente angular e linear
        # m = (y1 - y0)/(x1 - x0)
        # n = y0 - m * x0

        if (yp < y0) != (yp < y1) and xp <= x1 + ((yp - y1)/(y1-y0))*(x1-x0):

            d += 1

        x0 = x1
        y0 = y1

    return d % 2 == 1
