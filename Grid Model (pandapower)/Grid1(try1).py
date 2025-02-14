# -*- coding: utf-8 -*-
"""
Created on Fri May  1 12:38:34 2020

@author: Caner
"""
import pandapower as pp
import pandapower.toolbox as tb
import pandapower.networks as nw
from pandapower.plotting import simple_plot, simple_plotly, pf_res_plotly
#create empty net
net = pp.create_empty_network() 

#create buses
b1 = pp.create_bus(net, vn_kv=20., name="Bus 1")
b2 = pp.create_bus(net, vn_kv=0.4, name="Bus 2")
b3 = pp.create_bus(net, vn_kv=0.4, name="Bus 3")

#create bus elements
pp.create_ext_grid(net, bus=b1, vm_pu=1.02, name="Grid Connection")
#print(net.ext_grid)

pp.create_load(net, bus=b3, p_mw=0.1, q_mvar=0.05, name="Load")
#print(net.load)

#create branch elements
tid = pp.create_transformer(net, hv_bus=b1, lv_bus=b2, std_type="0.4 MVA 20/0.4 kV", name="Trafo")
#print(pp.available_std_types(net, "trafo"))

pp.create_line(net, from_bus=b2, to_bus=b3, length_km=0.1, name="Line",std_type="NAYY 4x50 SE")   
#print(pp.available_std_types(net, "line"))

#run power flow
pp.runpp(net)


#Results
print(net)
print(net.res_bus)
#tb.lf_info(net)
#simple_plot(net)
#pf_res_plotly(net)

#simple_plotly(net, respect_switches=True, use_line_geodata=None, on_map=False, projection=None, map_style='basic', figsize=1, aspectratio='auto', line_width=1, bus_size=10, ext_grid_size=20.0, bus_color='blue', line_color='grey', trafo_color='green', ext_grid_color='yellow')