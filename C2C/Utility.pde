void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -8, -8);
  line(0, 0, 8, -8);
  popMatrix();
}

void button(int x, int y, int w, int h, String text, color buttonColor, color textColor) {
  rectMode(CORNER);
  stroke(textColor);
  fill(buttonColor);
  rect(x, y, w, h);
  fill(textColor);
  textFont(createFont("Arial", h / 3, true));
  text(text, x + w / 10, y + h / 1.7);
}

void button2(int x, int y, int w, int h, String text, color buttonColor, color textColor) {
  rectMode(CORNER);
  stroke(textColor);
  fill(buttonColor);
  rect(x, y, w, h);
  fill(textColor);
  textFont(createFont("Arial", h / 3, true));
  text(text, x, y + 5);
}

String removeLastChar(String s) {
  return (s == null || s.length() == 0)
    ? null
    : (s.substring(0, s.length() - 1));
}
