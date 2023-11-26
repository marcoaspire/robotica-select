SelectBox sb; //<>//
   int objetoSeleccionado;
void setup(){
   size(300,300);
   sb = new SelectBox("test", new PVector(20,20), new PVector(150,50)); 
   sb.addItem("Valor 1");
   sb.addItem("Valor 2");
   sb.addItem("Valor 3");

}

void draw(){
    background(200);
    sb.dibujar();
}

void mousePressed(){ 
    println(mouseX + "," + mouseY );

    sb.opcionSelecionada();
    

    /* size = sb.items.size(); //<>//
    pos inicial = sb.pos.y; 
    // sb.pos.y + dim.y
    int itemSeleccionado = 100 - inicial/dim.y;
    */
   if (sb.expandirSelect(mouseX,mouseY))
   {
   } 
}


class SelectBox{
    private ArrayList<String> items;
    private String name;
    private Boolean expandido;
    public PVector pos; // 
    public PVector dim; //  ancho y alto
    private color colorFondo;
    private color colorTexto;

    SelectBox(String name, PVector pos, PVector dim){
        items = new ArrayList<String>();
        this.name = name;
        this.pos = pos;
        this.dim = dim;
        this.expandido = false;
        colorFondo = color(200);
        colorTexto = color(100);
    }

    public void dibujar(){
        pushMatrix();
        translate(pos.x, pos.y);
        fill(colorFondo);
        rect(0, 0, dim.x, dim.y);
        fill(colorTexto);
        text("Select an item",5,0.7*dim.y);

        if (expandido){

            // pintar
            /*
            fill(0);
            rect(0, 0, dim.x, dim.y);
            fill(colorTexto);
            text("Select an item",5,0.7*dim.y);
            */
            int i=0;
            for (String s : items) {
                i++;
                fill(255);
                rect(5,dim.y*i,dim.x,dim.y);
                fill(colorTexto);
                text(s,10,(dim.y*(i+1)-5));
                noFill();
            }
        }    

        popMatrix();
    }

    public void addItem(String c){
        items.add(c);
    }

    public String getName(){
        return this.name;
    }

    public Boolean puntoSobrePrincipal(int px, int py){
        return px>pos.x && px < pos.x+dim.x && py>pos.y && py<pos.y+dim.y ;
    }

    public Boolean expandirSelect(int px, int py){
        if (puntoSobrePrincipal(px,py)){
            expandido = true;
            return expandido;
        }
        return false ;
    }

    public boolean opcionSelecionada(){

        // verificar x
        objetoSeleccionado = (int) ((mouseY-sb.pos.y) /sb.dim.y);
        println("Item sele="+objetoSeleccionado);
        int y = (int) (objetoSeleccionado * sb.dim.y +sb.pos.y);
        println("y="+ y );
        // pinto el nuevo 
        fill(0);
        rect(sb.pos.x+5,y,sb.dim.x,sb.dim.y);
        fill(100);
        text("qwerty",5,0.7*sb.dim.y);

        return false;
    }

}
