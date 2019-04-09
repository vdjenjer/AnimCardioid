uses GraphWPF;
 
procedure Cardioid(n: integer; col: color := colors.YellowGreen);
begin
  var DotColor := colors.Red; // Цвет точек на окружности
  var DotRadius := 3; // Радиус точек на окружности
  var x := new real[n]; // Массивы для хранения координат
  var y := new real[n]; // центров точек
  pen.Color := colors.Gold; // Цвет главной окружности
  pen.Width := 5;
  // Центр главной окружности – в центре экрана
  var (Hu, Hv) := (Window.Width / 2, Window.Height / 2);
  var r0 := min(Hu, Hv) * 0.9; // Радиус главной окружности
  DrawCircle(Hu, Hv, r0);
  // Размещаем n равноотстоящих точек на окружности
  // Точки следуют через phi радиан, начиная с позиции start
  var (phi, start) := (-2 * pi / n, 0);
  pen.Color := DotColor;
  Font.Size := 20; // Кегль шрифта для нумерации точек
  // Для всех точек:
  for var i := 0 to n - 1 do
  begin
    // Вычисляем координаты i-ой точки
    x[i] := r0 * cos(i * phi + start) + Hu;
    y[i] := r0 * sin(i * phi + start) + Hv;
    // Рисуем точку и подписываем её номер
    circle(x[i], y[i], DotRadius, DotColor);
    var u := r0 * 1.075 * cos(i * phi + start) + Hu - 15;
    var v := r0 * 1.075 * sin(i * phi + start) + Hv - 10;
    DrawText(u, v, 50, 20, $'{i}', DotColor, LeftCenter);
  end;
  // Линии между точками i --- 2 * i (mod N)
  Pen.Color := col;
  Pen.Width := 2;
  for var i := 0 to n - 1 do
    Line(x[i], y[i], x[2 * i mod n], y[2 * i mod n]);
end;

 
begin
  Window.Maximize;
  //Cardioid(10); 
  var Count := 100;
  Window.Title := $'Кардиоида как огибающая семейства хорд ({Count} точек)';
  BeginFrameBasedAnimation((i: integer)->
  begin
    Cardioid(i);
    i += 1;
    if i > 100 then
      EndFrameBasedAnimation;
  end
  )
  
end.