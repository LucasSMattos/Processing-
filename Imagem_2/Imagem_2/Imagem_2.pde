PImage img;

//número de samples de cores a cada n pixels
int resolution = 3;
//array que guarda os substitutos dos pixels
char[] ascii;

void setup() {
  img = loadImage ("blas.jpg");
  //size(1920, 1080);
  size(960, 540);
  background (255);
  fill(255, 0, 0); //cor da fonte
  noStroke();

  //array de símbolos de acordo com clareza
  ascii = new char[255];
  String letters = "MN@#$*o);:,. ";
  for (int i = 0; i < 255; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }

  PFont mono = createFont("Courier", resolution +2);
  textFont(mono);

  asciify();
}

void asciify() {
 // img.filter(GRAY); //muda a imagem pra escala de cinza
  //img.loadPixels();
  
  image(img, 0, 0, width, height);
  loadPixels();
  background(255);
//pega a cor de cada grupo de pixels (baseado na resolução) e define um caractere
//de a cordo com a clareza da área
  for (int y = 0; y < height; y += resolution) {
    for (int x = 0; x < width; x += resolution) {
      //color pixel = img.pixels[y * img.width + x];
      color pixel = pixels[y * width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}
