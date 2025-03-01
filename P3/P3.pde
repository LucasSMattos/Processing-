import processing.video.*;

int resolution = 6; //número de samples de pixels que vão virar caracteres
char[] ascii; //array que guarda os substitutos dos pixels
Capture video;

void captureEvent(Capture event) {
  event.read();
}

void setup() {
  //checagem pra conferir o funcionamento da câmera, usa a primeira encontrada
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("Nenhuma câmera disponível.");
    exit(); //fecha o programa caso não encontre câmeras
  } else {
    println("Câmeras disponíveis:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
    }
    video = new Capture(this, width, height, cameras[0]); //usa a primeira câmera encontrada
  }
  
  size(1280, 720);
  video.start();
  
  //array de símbolos de acordo com clareza 
  ascii = new char[256];
  String letters = "MN@#$*o);:,. ";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 255, 0, letters.length() - 1)); //tive alguns problemas com o array ficando fora dos limites, o -1 corrige isso 
    ascii[i] = letters.charAt(index);
  }
  PFont mono = createFont("Courier", resolution + 2);
  textFont(mono);
  fill(255, 0, 0); //cor da fonte
  noStroke();
}

void draw() {
  background(255); //cor de fundo
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
