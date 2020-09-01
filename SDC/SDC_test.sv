module SDC_test;

logic driving_mode;
logic manual_ignition;
logic Auto_ignition;
logic SDC_close;
logic PowerOnreset;
logic WatchdogOutput;
logic Shutdown;
logic SDCrelais;
logic SDCready;

newSDC uut (.TO_SDC_relais(SDCrelais), .SDC_is_Ready(SDCready),
 .AS_close_SDC(SDC_close), .AS_driving_mode(driving_mode),
 .TS_Activation_Button_cockpit(manual_ignition), .TS_Activation_Button_external(Auto_ignition),
 .Power_on_Reset(PowerOnreset), .Watchdog(WatchdogOutput), .Shutdown_circuit(Shutdown));

 initial begin
     //sets all to zero as the car and all its systems are turnedoff
     PowerOnreset = 1'b0;
     driving_mode = 1'b0;
     SDC_close = 1'b0;
     WatchdogOutput = 1'b0;
     manual_ignition = 1'b0;
     Auto_ignition = 1'b0;
     Shutdown = 1'b0;

     #10

     PowerOnreset = 1'b1;
     SDC_close = 1'b1;
     WatchdogOutput = 1'b1;
     Shutdown = 1'b1;
    
    #10

    manual_ignition = 1'b1;
    #1 // creating a pulse
    manual_ignition = 1'b0;

    #10
    // reseting the system

    PowerOnreset = 1'b0;
    #1
    PowerOnreset = 1'b1;
    // turning on the system in the wrong mode
    #5

    Auto_ignition = 1'b1;
    #1 // creating a pulse
    Auto_ignition = 1'b0;

    #10 //reseting the system
    PowerOnreset = 1'b0;
    #1
    PowerOnreset = 1'b1;
    #5
    // turning on Autonamus capabilities while it is on the right mode
    driving_mode = 1'b1;
    Auto_ignition = 1'b1;
    #1 // creating a pulse
    Auto_ignition = 1'b0;
    
    
    





 end
endmodule