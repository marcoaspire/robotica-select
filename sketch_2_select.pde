SelectBox sb; //<>//
SelectBox sb2;
Circulo cir;
Boolean estaExpandido = false;
void setup() {
  size(300, 300);
  sb = new SelectBox("test", new PVector(20, 20), new PVector(150, 20));
  sb.addItem("Valor 1");
  sb.addItem("Valor 2");
  sb.addItem("Valor 3");
  sb2 = new SelectBox("test2", new PVector(20, 100), new PVector(150, 20));
  sb2.addItem("A");
  sb2.addItem("B");
  sb2.addItem("C");
  cir = new Circulo(150, 200, 50);
}

void draw() {
  background(200);
  sb2.dibujar();
  sb.dibujar();
  cir.dibuja();
}

void mouseMoved() {
    if (sb.isExpandido())
  {
    sb.opcionSelecionada();
  }

  if (sb2.isExpandido())
  {
    sb2.opcionSelecionada();
  }

}

void mousePressed() {
   if (cir.verificaCoordenadas(mouseX, mouseY))
   {
     println("Opc 1:" + sb.getOpcionSelecionada() + "  opc2: " + sb2.getOpcionSelecionada() );
   }
  if (sb.expandirSelect(mouseX, mouseY))
  {
    sb2.contraerSelect();
  }
  
  if (sb.isExpandido())
  {
    if (sb.opcionSelecionada())
        sb.contraerSelect();
  }

  if (sb2.isExpandido())
  {
    if (sb2.opcionSelecionada())
        sb2.contraerSelect();

  }

  if (sb2.expandirSelect(mouseX, mouseY))
  {
    sb.contraerSelect();
  }
}

class SelectBox {
  private ArrayList<String> items;
  private String name;
  private Boolean expandido;
  private PVector pos; //
  private PVector dim; //  ancho y alto
  private color colorFondo;
  private color colorTexto;
  private Integer opcionSeleccionada;

  SelectBox(String name, PVector pos, PVector dim) {
    items = new ArrayList<String>();
    this.name = name;
    this.pos = pos;
    this.dim = dim;
    this.expandido = false;
    colorFondo = color(200);
    colorTexto = color(100);
    opcionSeleccionada = -1;
  }

  public void dibujar() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(colorFondo);
    rect(0, 0, dim.x, dim.y);
    fill(colorTexto);

    if (opcionSeleccionada >= 0 && opcionSeleccionada< items.size() )
      text(items.get(opcionSeleccionada), 5, 0.7*dim.y);
    else
      text("Select an item", 5, 0.7*dim.y);
    
    if (expandido) {
      for (int i=0; i< items.size(); i++) {
        if (i == opcionSeleccionada)
        {
          fill(200);
        } else
        {
          fill(255);
        }
        rect(5, dim.y*(i+1), dim.x, dim.y);
        fill(colorTexto);
        text(items.get(i), 10, (dim.y*(i+1+1)-5));
      }
    }
    popMatrix();
  }

  public void addItem(String c) {
    items.add(c);
  }

  public String getName() {
    return this.name;
  }

  public Boolean puntoSobrePrincipal(int px, int py) {
    return px>pos.x && px < pos.x+dim.x && py>pos.y && py<pos.y+dim.y ;
  }

  public Boolean expandirSelect(int px, int py) {
    if (puntoSobrePrincipal(px, py) && !expandido) {
      this.expandido = !expandido;
      estaExpandido = !estaExpandido;
      return expandido;
    }
    return false ;
  }

  public void contraerSelect() {
    this.expandido = false;

  }

  public Boolean isExpandido(){
    return this.expandido;
  }

  public Boolean opcionSelecionada() {
    int posibleOpcion = -1;
    if (mouseX > (pos.x+5) && mouseX<= dim.x  )
    {
        posibleOpcion = (int) ((mouseY-pos.y) /dim.y) -1;
    }

    if (posibleOpcion == -1 )
        return false;
    if (posibleOpcion >= 0 && posibleOpcion < items.size() )
    {
      opcionSeleccionada = posibleOpcion;
      int y = (int) (opcionSeleccionada * dim.y +pos.y);
      return true;
    }
    else
      this.contraerSelect();
    return false;
  }
  public String getOpcionSelecionada() {
    if (opcionSeleccionada >= 0 && opcionSeleccionada < items.size() )
    {
       return items.get(opcionSeleccionada);
    }
    return "Opcion no seleccionada";

  }
}


class Circulo{
  int x; 
  int y; 
  int d;
  Circulo(int x, int y, int d)
  {
    this.x = x;
    this.y = y;
    this.d = d;
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  int getD(){
    return d;
  }
  
  void dibuja(){
    noFill();
    circle(x, y, d);
  }
  
  void pinta(int c){
    fill(c);
    circle(x, y, d);
  }
  
  boolean verificaCoordenadas(int x1, int y1)
  {
      float distancia;
      float radio = getD()/2;
      distancia = sqrt(   sq(x- x1) + sq(y - y1)  );
      return distancia<=radio;
  }

}
