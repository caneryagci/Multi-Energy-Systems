# -*- coding: utf-8 -*-
"""
Created on Sun May  3 15:07:11 2020

@author: Caner
"""
import os
import pandas as pd
import pandapower as pp
import matplotlib.pyplot as plt
import pandapower.toolbox as tb
from pandapower.plotting import simple_plot, simple_plotly, pf_res_plotly
net = pp.create_empty_network()

#create buses
bus1 = pp.create_bus(net, vn_kv=220., min_vm_pu=1.0, max_vm_pu=1.02, name ='bus 1')
bus2 = pp.create_bus(net, vn_kv=110., min_vm_pu=1.0, max_vm_pu=1.02, name ='bus 2')
bus3 = pp.create_bus(net, vn_kv=110., min_vm_pu=1.0, max_vm_pu=1.02, name ='bus 3')


#create 220/110 kV transformer
pp.create_transformer(net, bus1, bus2, std_type="100 MVA 220/110 kV", max_loading_percent=100)

#create 110 kV lines
pp.create_line(net, bus2, bus3, length_km=30., std_type='149-AL1/24-ST1A 110.0', max_loading_percent=100)

#create loads
pp.create_load(net, bus3, p_mw=60, q_mvar=0, sn_mva=10000, min_p_mw=0,max_p_mw=100, max_q_mvar=10000, min_q_mvar=-10000, scaling=1.0, in_service=True, controllable=False,name='Power2Gas',)
pp.create_load(net, bus3, p_mw=50, q_mvar=0, sn_mva=10000, min_p_mw=0,max_p_mw=100, max_q_mvar=10000, min_q_mvar=-10000, scaling=1.0, in_service=True, controllable=False,name='Electrical',)
pp.create_load(net, bus3, p_mw=20, q_mvar=0, sn_mva=10000, min_p_mw=0,max_p_mw=100, max_q_mvar=10000, min_q_mvar=-10000, scaling=1.0, in_service=False, controllable=False,name='Power2Heat')

#create generators
eg = pp.create_ext_grid(net, bus1)
g0 = pp.create_gen (net, bus3, p_mw=80, vm_pu=1.01, sn_mva=1000, name='PV', index=None, max_q_mvar=10000, min_q_mvar=-10000, min_p_mw=0, max_p_mw=100, scaling=1.0, type=None, slack=False, controllable=False, in_service=True)
#g1 = pp.create_gen(net, bus3, p_mw=100, min_p_mw=0, max_p_mw=100, vm_pu=1.01, controllable=True)
g1 = pp.create_gen(net, bus3, p_mw=50, vm_pu=1.01, sn_mva=1000, name='WF', index=None, max_q_mvar=10000, min_q_mvar=-10000, min_p_mw=0, max_p_mw=100, scaling=1.0, type=None, slack=False, controllable=False, in_service=True)



#Maximizing Generation
pp.create_poly_cost(net, 1, 'gen', cp1_eur_per_mw=-1)
pp.create_pwl_cost(net, 1, "gen", [[net.gen.min_p_mw.at[0], net.gen.max_p_mw.at[0], -1]])
pp.create_poly_cost(net, 0, 'gen', cp1_eur_per_mw=-1)
pp.create_pwl_cost(net, 0, "gen", [[net.gen.min_p_mw.at[0], net.gen.max_p_mw.at[0], -1]])

#Minimizing Load
#pp.create_poly_cost(net, 0, 'load', cp1_eur_per_mw=1)
#pp.create_pwl_cost(net, 0, "load", [[net.load.min_p_mw.at[0], net.load.max_p_mw.at[0], 1]])
#pp.create_poly_cost(net, 0, 'storage', cp1_eur_per_mw=1)
#pp.create_pwl_cost(net, 0, "storage", [[net.storage.min_p_mw.at[0], net.storage.max_p_mw.at[0], 1]])

pp.runopp(net, verbose=True)

# save as pickle
simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Grid Model (pandapower)'
pp.to_pickle(net, os.path.join(simulators_dir, 'gridModel.p'))  # absolute path

#print(net.res_bus)
print(net.res_gen)
print(net.res_load)
print(net.res_ext_grid)





