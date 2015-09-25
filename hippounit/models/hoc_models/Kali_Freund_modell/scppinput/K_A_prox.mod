COMMENT

   **************************************************
   File generated by: neuroConstruct v1.5.1 
   **************************************************

   This file holds the implementation in NEURON of the Cell Mechanism:
   K_A_prox (Type: Channel mechanism, Model: ChannelML based process)

   with parameters: 
   /channelml/@units = SI Units 
   /channelml/notes = ChannelML file containing a single Channel description 
   /channelml/channel_type/@name = K_A_prox 
   /channelml/channel_type/status/@value = stable 
   /channelml/channel_type/status/comment = Equations adapted from Kali, based on Golomb et al. 
   /channelml/channel_type/status/contributor/name = Bogl�rka Sz?ke 
   /channelml/channel_type/notes = K channel for fast pyramidneurons 
   /channelml/channel_type/authorList/modelTranslator/name = Bogl�rka Sz?ke 
   /channelml/channel_type/authorList/modelTranslator/institution = PPKE-ITK 
   /channelml/channel_type/authorList/modelTranslator/email = szoboce - at - digitus.itk.ppke.hu 
   /channelml/channel_type/current_voltage_relation/@cond_law = ohmic 
   /channelml/channel_type/current_voltage_relation/@ion = k 
   /channelml/channel_type/current_voltage_relation/@default_gmax = 90 
   /channelml/channel_type/current_voltage_relation/@default_erev = -0.080 
   /channelml/channel_type/current_voltage_relation/gate[1]/@name = X 
   /channelml/channel_type/current_voltage_relation/gate[1]/@instances = 2 
   /channelml/channel_type/current_voltage_relation/gate[1]/closed_state/@id = X0 
   /channelml/channel_type/current_voltage_relation/gate[1]/open_state/@id = X 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@name = alpha 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@from = X0 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@to = X 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@expr_form = exponential 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@rate = 450 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@scale = 0.024 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[1]/@midpoint = -0.0054 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@name = beta 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@from = X 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@to = X0 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@expr_form = exponential 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@rate = 450 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@scale = -0.024 
   /channelml/channel_type/current_voltage_relation/gate[1]/transition[2]/@midpoint = -0.0054 
   /channelml/channel_type/current_voltage_relation/gate[2]/@name = Y 
   /channelml/channel_type/current_voltage_relation/gate[2]/@instances = 1 
   /channelml/channel_type/current_voltage_relation/gate[2]/closed_state/@id = Y0 
   /channelml/channel_type/current_voltage_relation/gate[2]/open_state/@id = Y 
   /channelml/channel_type/current_voltage_relation/gate[2]/time_course/@name = tau 
   /channelml/channel_type/current_voltage_relation/gate[2]/time_course/@from = Y0 
   /channelml/channel_type/current_voltage_relation/gate[2]/time_course/@to = Y 
   /channelml/channel_type/current_voltage_relation/gate[2]/time_course/@expr_form = generic 
   /channelml/channel_type/current_voltage_relation/gate[2]/time_course/@expr = v &gt; -0.030 ? 0.26*(v + 0.030) + 0.005 : 0.005 
   /channelml/channel_type/current_voltage_relation/gate[2]/steady_state/@name = inf 
   /channelml/channel_type/current_voltage_relation/gate[2]/steady_state/@from = Y 
   /channelml/channel_type/current_voltage_relation/gate[2]/steady_state/@to = Y0 
   /channelml/channel_type/current_voltage_relation/gate[2]/steady_state/@expr_form = generic 
   /channelml/channel_type/current_voltage_relation/gate[2]/steady_state/@expr = 1 / (1 + (exp (125*(v + 0.051)))) 
   /channelml/channel_type/impl_prefs/table_settings/@max_v = 0.05 
   /channelml/channel_type/impl_prefs/table_settings/@min_v = -0.1 
   /channelml/channel_type/impl_prefs/table_settings/@table_divisions = 3000 

// File from which this was generated: /home/kali/nC_projects/CA1_NEURON/cellMechanisms/K_A_prox/K_A_prox.xml

// XSL file with mapping to simulator: /home/kali/nC_projects/CA1_NEURON/cellMechanisms/K_A_prox/ChannelML_v1.8.1_NEURONmod.xsl

ENDCOMMENT


?  This is a NEURON mod file generated from a ChannelML file

?  Unit system of original ChannelML file: SI Units

COMMENT
    ChannelML file containing a single Channel description
ENDCOMMENT

TITLE Channel: K_A_prox

COMMENT
    K channel for fast pyramidneurons
ENDCOMMENT


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
    (um) = (micrometer)
    (molar) = (1/liter)
    (mM) = (millimolar)
    (l) = (liter)
}


    
NEURON {
      

    SUFFIX K_A_prox
    USEION k READ ek WRITE ik VALENCE 1  ? reversal potential of ion is read, outgoing current is written
           
        
    RANGE gmax, gion, ik
    
    RANGE Xinf, Xtau
    
    RANGE Yinf, Ytau
    
}

PARAMETER { 
      

    gmax = 0.0090 (S/cm2)  ? default value, should be overwritten when conductance placed on cell
    
}



ASSIGNED {
      

    v (mV)
    
    celsius (degC)
          

    ? Reversal potential of k
    ek (mV)
    ? The outward flow of ion: k calculated by rate equations...
    ik (mA/cm2)
    
    
    gion (S/cm2)
    Xinf
    Xtau (ms)
    Yinf
    Ytau (ms)
    
}

BREAKPOINT { 
                        
    SOLVE states METHOD cnexp
         

    gion = gmax*((X)^2)*((Y)^1)      

    ik = gion*(v - ek)
            

}



INITIAL {
    
    ek = -80
        
    rates(v)
    X = Xinf
        Y = Yinf
        
    
}
    
STATE {
    X
    Y
    
}

DERIVATIVE states {
    rates(v)
    X' = (Xinf - X)/Xtau
    Y' = (Yinf - Y)/Ytau
    
}

PROCEDURE rates(v(mV)) {  
    
    ? Note: not all of these may be used, depending on the form of rate equations
    LOCAL  alpha, beta, tau, inf, gamma, zeta, temp_adj_X, A_alpha_X, B_alpha_X, Vhalf_alpha_X, A_beta_X, B_beta_X, Vhalf_beta_X, temp_adj_Y, A_tau_Y, B_tau_Y, Vhalf_tau_Y, A_inf_Y, B_inf_Y, Vhalf_inf_Y
        
    TABLE Xinf, Xtau,Yinf, Ytau
 DEPEND celsius
 FROM -100 TO 50 WITH 3000
    
    
    UNITSOFF
    temp_adj_X = 1
    temp_adj_Y = 1
    
            
                
           

        
    ?      ***  Adding rate equations for gate: X  ***
        
    ? Found a parameterised form of rate equation for alpha, using expression: A*exp((v-Vhalf)/B)
    A_alpha_X = 450
    B_alpha_X = 0.024
    Vhalf_alpha_X = -0.0054   
    
    ? Unit system in ChannelML file is SI units, therefore need to convert these to NEURON quanities...
    
    A_alpha_X = A_alpha_X * 0.0010   ? 1/ms
    B_alpha_X = B_alpha_X * 1000   ? mV
    Vhalf_alpha_X = Vhalf_alpha_X * 1000   ? mV
          
                     
    alpha = A_alpha_X * exp((v - Vhalf_alpha_X) / B_alpha_X)
    
    
    ? Found a parameterised form of rate equation for beta, using expression: A*exp((v-Vhalf)/B)
    A_beta_X = 450
    B_beta_X = -0.024
    Vhalf_beta_X = -0.0054   
    
    ? Unit system in ChannelML file is SI units, therefore need to convert these to NEURON quanities...
    
    A_beta_X = A_beta_X * 0.0010   ? 1/ms
    B_beta_X = B_beta_X * 1000   ? mV
    Vhalf_beta_X = Vhalf_beta_X * 1000   ? mV
          
                     
    beta = A_beta_X * exp((v - Vhalf_beta_X) / B_beta_X)
    
    Xtau = 1/(temp_adj_X*(alpha + beta))
    Xinf = alpha/(alpha + beta)
          
       
    
    ?     *** Finished rate equations for gate: X ***
    

    
            
                
           

        
    ?      ***  Adding rate equations for gate: Y  ***
         
    ? Found a generic form of the rate equation for tau, using expression: v > -0.030 ? 0.26*(v + 0.030) + 0.005 : 0.005
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.0010   ? temporarily set v to units of equation...
            
    
    
    if (v > -0.030 ) {
        tau =  0.26*(v + 0.030) + 0.005 
    } else {
        tau =  0.005
    }
    ? Set correct units of tau for NEURON
    tau = tau * 1000 
    
    v = v * 1000   ? reset v
        
    Ytau = tau/temp_adj_Y
     
    ? Found a generic form of the rate equation for inf, using expression: 1 / (1 + (exp (125*(v + 0.051))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.0010   ? temporarily set v to units of equation...
            
    inf = 1 / (1 + (exp (125*(v + 0.051))))
         
    
    v = v * 1000   ? reset v
        
    Yinf = inf
          
       
    
    ?     *** Finished rate equations for gate: Y ***
    

         

}


UNITSON


