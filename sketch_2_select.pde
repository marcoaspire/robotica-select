SelectBox sb; //<>// //<>//
int objetoSeleccionado;
void setup() {
  size(300, 300);
  sb = new SelectBox("test", new PVector(20, 20), new PVector(150, 50));
  sb.addItem("Valor 1");
  sb.addItem("Valor 2");
  sb.addItem("Valor 3");
}

void draw() {
  background(200);
  sb.dibujar();
}

void mousePressed() {
  println(mouseX + "," + mouseY );

  sb.opcionSelecionada();


  /* size = sb.items.size();
   pos inicial = sb.pos.y;
   // sb.pos.y + dim.y
   int itemSeleccionado = 100 - inicial/dim.y;
   */
  if (sb.expandirSelect(mouseX, mouseY))
  {
  }
}

class OptionSelect {
  private String texto;
  private Boolean isSelected;
  OptionSelect(String texto ) {
    this.texto = texto;
    isSelected = false;
  }

  void select() {
    isSelected = !isSelected;
    // rect(5,dim.y,dim.x,dim.y); // 1 y 2, location upper-left corner, 3-width, 4-height
  }
  
  Boolean isSelected() {
    return isSelected;
  }
  
  String getTexto(){
    return this.texto;
  }
}
class SelectBox {
  private ArrayList<OptionSelect> items;
  private String name;
  private Boolean expandido;
  public PVector pos; //
  public PVector dim; //  ancho y alto
  private color colorFondo;
  private color colorTexto;
  private Integer opcionSeleccionada;

  SelectBox(String name, PVector pos, PVector dim) {
    items = new ArrayList<OptionSelect>();
    this.name = name;
    this.pos = pos;
    this.dim = dim;
    this.expandido = false;
    colorFondo = color(200);
    colorTexto = color(100);
  }

  public void dibujar() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(colorFondo);
    rect(0, 0, dim.x, dim.y);
    fill(colorTexto);
    text("Select an item", 5, 0.7*dim.y);

    if (expandido) {
      // pintar
      /*
            fill(0);
       rect(0, 0, dim.x, dim.y);
       fill(colorTexto);
       text("Select an item",5,0.7*dim.y);
       */
      for (int i=0; i< items.size();i++) {
        if (items.get(i).isSelected())
          fill(100);
        else
          fill(255);
        rect(5, dim.y*(i+1), dim.x, dim.y);
        fill(colorTexto);
        text(items.get(i).getTexto(), 10, (dim.y*(i+1+1)-5));
        noFill();
      }
    } else {
    }

    popMatrix();
  }

  public void addItem(String c) {
    items.add(new OptionSelect(c));
  }

  public String getName() {
    return this.name;
  }

  public Boolean puntoSobrePrincipal(int px, int py) {
    return px>pos.x && px < pos.x+dim.x && py>pos.y && py<pos.y+dim.y ;
  }

  public Boolean expandirSelect(int px, int py) {
    if (puntoSobrePrincipal(px, py)) {
      expandido = !expandido;
      return expandido;
    }
    return false ;
  }

  public boolean opcionSelecionada() {

    // verificar x
    objetoSeleccionado = (int) ((mouseY-sb.pos.y) /sb.dim.y);
    println("Item sele="+objetoSeleccionado);
    if (objetoSeleccionado > 0 && objetoSeleccionado<= items.size() )
    {
      items.get(objetoSeleccionado-1).select();
      int y = (int) (objetoSeleccionado * sb.dim.y +sb.pos.y);
      println("y="+ y );
    
    }
    
    
    
    return false;
  }
}
