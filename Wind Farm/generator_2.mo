model generator_2
import Modelica.ComplexMath;
  import Modelica.Constants.pi;
  constant Complex j = Complex(0, 1) "Imaginary unit";
  //e.g. Complex c4 = (-2) + 5 * j;
  
  OpenIPSL.Interfaces.PwPin pin annotation (Placement(
      visible=true,
      transformation(
        origin={-158.307,1.6927},
        extent={{-10, -10}, {10, 10}},
        rotation=0),
      iconTransformation(
        origin={90, 0},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  
  parameter Real Sbase=100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real Vbus0=400 " Input PowerFlow";
  parameter Real angle0=-0.00243 "Angle PowerFlow";
  parameter Real Pc=16e+6 "Active Power , PowerFlow";
  parameter Real Qc=5e+6 "Reactive Power, Power Flow";
  parameter Real poles=2 "Number of poles-pair";
  parameter Real omega_m0=0.58;
  parameter Real omega_r0= omega_m0*poles;
  parameter Real Pnom=10 "Nominal Power (MVA)";
  //parameter Real Vbase=400 "Voltage rating (kV)";
  //parameter Real freq=50 "frequency rating (Hz)";
  parameter Real Lls = 0.06492e-3 "stator leakage inductance(H)"; 
  parameter Real Llr = 0.06492e-3 "rotor leakage inductance(H)"; 
  parameter Real Lm = 2.13461e-3 "magnetizing inductance(H)"; 
  parameter Real Xm = 2*pi*50*Lm "magnetization reactance(ohm)";
  parameter Real Xr = 2*pi*50*Llr "rotor leakage reactance(ohm)";
  parameter Real Xs = 2*pi*50*Lls "stator leakage reactance(ohm)";
  parameter Real x1=Xm + Xs "stator plus magnetisation impedances";
  parameter Real Ls = Lls+Lm "stator self inductance(H)";
  parameter Real Lr = Llr+Lm "rotor self inductance(H)"; 
  parameter Real Rs = 1.102e-3 "stator winding resistance";
  parameter Real Rr = 1.497e-3 "rotor winding resistance";
  parameter Real Hm = 5.8078 "inertia time constant (s)";
  parameter Real Tm0 = 30740"engine shaft torque(N.m)";
  parameter Real w = 2*pi*50 "Rotating speed of the arbitrary reference frame(rad/s)";
  parameter Real J=1200 "moment of inertia (kg.m2)";
  
  parameter Real vds0=-Vbus0*sin(angle0);
  parameter Real vqs0=Vbus0*cos(angle0);
  parameter Real vdr0=(-Rr*idr0) + (1 - omega_m0)*((Xm + Xr)*iqr0 + Xm*iqs0);
  parameter Real vqr0=(-Rr*iqr0) - (1 - omega_m0)*((Xm + Xr)*idr0 + Xm*ids0);
  parameter Real ids0=((-vds0^2) + vds0*Xm*iqr0 - x1*Qc)/(Rs*vds0 - x1*vqs0);
  parameter Real iqs0=((-vds0*vqs0) + vqs0*Xm*iqr0 - Rs*Qc)/(Rs*vds0 - x1*vqs0);
  parameter Real idr0=-(vqs0 + Rs*iqs0 + x1*ids0)/Xm;
  parameter Real iqr0=-x1*Pnom*(2*omega_m0 - 1)/Vbus0/Xm/omega_m0;
  parameter Real flux_ds0=Ls*ids0+Lm*idr0;
  parameter Real flux_qs0=Ls*iqs0+Lm*iqr0;
  parameter Real flux_dr0=Lr*idr0+Lm*ids0;
  parameter Real flux_qr0=Lr*iqr0+Lm*iqs0;
  
  
  Complex Vs "stator voltage vector(V)";
  Complex Vr "rotor voltage vector(V)";
  Complex Is "stator current vector(A)";
  Complex Ir "rotor current vector(A)";
  Complex flux_s "stator flux linkage vector(Wb)";
  Complex flux_r "rotor flux linkage vector(Wb)";
  Complex Ps;
  Complex Qs;
  Complex Pr;
  Complex Qr;
  
  Real flux_ds(start=flux_ds0, fixed=false) "stator flux linkage vector(Wb)";
  Real flux_qs(start=flux_qs0, fixed=false) "stator flux linkage vector(Wb)";
  Real flux_dr(start=flux_dr0, fixed=false) "rotor flux linkage vector(Wb)";
  Real flux_qr(start=flux_qr0, fixed=false) "rotor flux linkage vector(Wb)";

  Real vds(start=vds0, fixed=false);
  Real vqs(start=vqs0, fixed=false);
  Real vdr(start=vdr0, fixed=false);
  Real vqr(start=vqr0, fixed=false);
  Real ids(start=ids0, fixed=false);
  Real iqs(start=iqs0, fixed=false);
  Real idr;
  Real iqr;
  Real wm;
  Real wr(start=omega_r0, fixed=false);
  Real Anglebus=atan(pin.vi/pin.vr);
  Real P(start=Pc, fixed=false)  "Active power";
  Real Q(start=Qc, fixed=false)  "Reactive Power";
  
  Modelica.Blocks.Interfaces.RealOutput omega_m "rotor mechanical angular speed(rad/s)" annotation(
    Placement(visible = true, transformation(origin = {110, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Tel "Electromagnetic torque" annotation(
    Placement(visible = true, transformation(origin = {111, -23}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vbus annotation(
    Placement(visible = true, transformation(origin = {110, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Tm annotation(
    Placement(visible = true, transformation(origin = {-102, 22}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
//initial equation
//wm = omega_m0;

equation
vqs = pin.vr;
vds = -pin.vi;
//iqs = pin.ii;
//ids = -pin.ir;
-P = pin.vr*pin.ir + pin.vi*pin.ii;
-Q = pin.vi*pin.ir - pin.vr*pin.ii;

//Calculate stator,rotor voltages
  Vs = Rs*Is+der(flux_s)+j*w*flux_s;
  Vr = Rs*Ir+der(flux_r)+j*(w-wr)*flux_r;
  /*
  vds = Rs*ids + der(flux_ds) - w*flux_qs;
  vqs = Rs*iqs + der(flux_qs) + w*flux_ds;
  vdr = Rr*idr + der(flux_dr) - (w-wr)*flux_qr;
  vqr = Rr*iqr + der(flux_qr) + (w-wr)*flux_dr;
  
  der(flux_ds) = vds - Rs*ids + w*flux_qs;
  //der(flux_qs) = vqs - Rs*iqs - w*flux_ds;
  //der(flux_dr) = vdr - Rr*idr + (w-wr)*flux_qr;
  //der(flux_qr) = vqr - Rr*iqr - (w-wr)*flux_dr;
  
  
//Calculate stator, rotor currents
 flux_s = Ls*Is+Lm*Ir;
 flux_r = Lm*Is+Lr*Ir;
 /* flux_ds=Ls*ids+Lm*idr;
  flux_qs=Ls*iqs+Lm*iqr;
  flux_dr=Lr*idr+Lm*ids;
  flux_qr=Lr*iqr+Lm*iqs;
  */
  
  Vs = vds + j*vqs;
  Vr = vdr + j*vqr;
  Is = ids + j*iqs;
  Ir = idr + j*iqr;
  flux_s =flux_ds + j*flux_qs;
  flux_r =flux_dr + j*flux_qr;
  
  Vbus = sqrt(vds^2 + vqs^2);
  Ps=(Vs*Complex(Is.re-j*Is.im));
  Qs=(Vs*Complex(Is.re-j*Is.im));
  Pr=(Vr*Complex(Ir.re-j*Ir.im));
  Qr=(Vr*Complex(Ir.re-j*Ir.im));
  P =(3/2)*(Ps.re);
  Q =(3/2)*Qs.im;
  //P = vds*ids + vqs*iqs + vdr*idr + vqr*iqr;
  //Q = (-Xm*Vbus*idr/x1) - Vbus^2/Xm;
  
  Tel = (3*poles/2)*(iqs*flux_ds - ids*flux_qs);
  der(wm) = (Tel - Tm)/J;
  wr = wm*poles;
  omega_m=wm;
annotation(
    Icon(graphics = {Text(origin = {94, 73}, extent = {{-6, -3}, {2, 1}}, textString = "omega_m"), Text(origin = {93, 33}, extent = {{-3, -3}, {1, -1}}, textString = "Tel"), Text(origin = {90, -71}, extent = {{-2, -1}, {2, 1}}, textString = "Vbus"), Text(origin = {30, -27}, lineColor = {0, 0, 255}, extent = {{-66, 73}, {14, -21}}, textString = "Gen"), Text(origin = {-79, 22}, extent = {{-1, 2}, {3, -4}}, textString = "Tm"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)),
    Diagram);end generator_2;
