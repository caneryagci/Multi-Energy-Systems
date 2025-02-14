within Hydrogen;

model P2G_basecase
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sb = 50,Sn = 100, V_b = 12500, Vn = 12500, fn = 50, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {24, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-4, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen( Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {63, -35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2(S_storage)  annotation(
    Placement(visible = true, transformation(origin = {-25, 51}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Hydrogen.electrolyser_detailed electrolyser_detailed1 annotation(
    Placement(visible = true, transformation(origin = {-68, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-68, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.LCOH lcoh annotation(
    Placement(visible = true, transformation(origin = {6, -116}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = electrolyser_detailed1.electrochemical.efficiency2)  annotation(
    Placement(visible = true, transformation(origin = {-28, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Controller_P2G3 controller_P2G3(S_emergency = 51)  annotation(
    Placement(visible = true, transformation(origin = {50.5198, 51.1101}, extent = {{-22.4881, -28.1101}, {37.4802, 18.7401}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T_ambient(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Tambient_hourly.txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-104, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 50)  annotation(
    Placement(visible = true, transformation(origin = {-106, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable Demand_Profile(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/gas_demand_half.txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-87, 89}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-108, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{13, -70}, {-4, -70}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus2.p) annotation(
    Line(points = {{-4, -70}, {-13, -70}, {-13, -72}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{44, -70}, {35, -70}}, color = {0, 0, 255}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{5, -34}, {29.5, -34}, {29.5, -35}, {48, -35}}, color = {0, 0, 127}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{84, -34}, {98, -34}, {98, -70}, {44, -70}}, color = {0, 0, 255}));
  connect(electrolyser_detailed1.nH2, storage2.nH2_i) annotation(
    Line(points = {{-45, -19}, {-6, -19}, {-6, 26}, {-62, 26}, {-62, 40}, {-39, 40}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, staticgen.P_0) annotation(
    Line(points = {{-44, 7}, {30, 7}, {30, -48}, {48, -48}}, color = {0, 0, 127}));
  connect(const.y, infiniteBus2.V) annotation(
    Line(points = {{-56, -72}, {-36, -72}, {-36, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(const.y, staticgen.V_0) annotation(
    Line(points = {{-56, -72}, {-44, -72}, {-44, -20}, {48, -20}, {48, -20}}, color = {0, 0, 127}));
  connect(realExpression.y, lcoh.efficiency) annotation(
    Line(points = {{-17, -120}, {-2, -120}}, color = {0, 0, 127}));
  connect(storage2.S_storage, controller_P2G3.S_storage) annotation(
    Line(points = {{-4, 58}, {18, 58}, {18, 64}, {35, 64}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.nH2, controller_P2G3.generation) annotation(
    Line(points = {{-45, -19}, {16, -19}, {16, 36}, {35, 36}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, controller_P2G3.P) annotation(
    Line(points = {{-44, 7}, {22, 7}, {22, 26}, {35, 26}}, color = {0, 0, 127}));
  connect(T_ambient.y[1], electrolyser_detailed1.T_ambient) annotation(
    Line(points = {{-92, -46}, {-82, -46}, {-82, -26}, {-106, -26}, {-106, -18}, {-84, -18}}, color = {0, 0, 127}));
  connect(const1.y, electrolyser_detailed1.Porder) annotation(
    Line(points = {{-94, 14}, {-94, 8}, {-82, 8}}, color = {0, 0, 127}));
  connect(Demand_Profile.y[1], storage2.nH2_o) annotation(
    Line(points = {{-72, 90}, {-54, 90}, {-54, 58}, {-38, 58}, {-38, 58}}, color = {0, 0, 127}));
  connect(Demand_Profile.y[1], controller_P2G3.demand) annotation(
    Line(points = {{-72, 90}, {10, 90}, {10, 50}, {34, 50}, {34, 52}, {34, 52}}, color = {0, 0, 127}));
  connect(constant1.y, controller_P2G3.ptg_switch) annotation(
    Line(points = {{-96, 52}, {-64, 52}, {-64, 42}, {36, 42}, {36, 44}, {36, 44}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(extent = {{-120, -120}, {120, 120}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}})));


end P2G_basecase;
