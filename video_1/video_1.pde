import processing.video.*;

//número de samples de cores a cada n pixels
int resolution = 6;
//array que guarda os substitutos dos pixels
char[] ascii;

Movie video;

void movieEvent(Movie filme) {
  video.read();
}

void setup() {
 size(1280, 720);
 video = new Movie(this, "blas.mp4");
 video.loop(); //ou filme.play();
  fill(255, 0, 0); //cor da fonte
  noStroke();

  //array de símbolos de acordo com clareza
  ascii = new char[256];
  String letters = "MN@#$*o);:,. ";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }

  PFont mono = createFont("Courier", resolution +2);
  textFont(mono);
}

void draw(){
  background(0);
  asciify();
}

void asciify() {
  //filme.filter(GRAY); //muda a imagem pra escala de cinza
  video.loadPixels();
  //seleciona um número de pixels de acordo com a resolução pré definida e transforma eles em um caractere
  for (int y = 0; y < video.height; y += resolution) {
    for (int x = 0; x < video.width; x += resolution) {
      // correção da linha que ficava embaixo da imagem no filtro usado no P2
      int idx = y * video.width + x;
      if (idx < video.pixels.length) {
        float brilho = brightness(video.pixels[idx]);
        text(ascii[int(brilho)], x, y + resolution);
    }
  }
}
}
