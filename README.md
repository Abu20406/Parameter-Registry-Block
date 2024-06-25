# Parameter-Registry-Block
An FSM implementing registry block to manage parameter loading and manipulation on input data as part of Digital System Design course.

 A Registry block implements a finite state machine (FSM) model for managing parameter loading and manipulation based on input data.
 
 **The inputs include:** clock signal (clk), a global reset signal (rst), data input (data) and a parameter load signal (param_ld).
 
 **The outputs include:** mask parameter (mask_param), code parameter (code_param) and synchronization jump width (sjw)

 ![image](https://github.com/Abu20406/Parameter-Registry-Block/assets/68015588/a3eb3b72-d5c2-4d0a-8e16-c674fad5a140)


 **Here's a high-level description of how this process works:**
 
**-** The module starts in the idle state, waiting for a parameter load (param_ld) signal to be asserted.

**-** When the param_ld signal is detected, the module transitions to the prmtr_0 state. In the prmtr_0 state, the module stores the least significant 8 bits of the incomin data_in as the mask parameter (mask_param).

**-** The module then transitions to the prmtr_1 state, where it further manipulates the mask_param and code_param values based on the incoming data_in.

**-** The prmtr_1 state transitions to the prmtr_2 state, where the code parameter (code_param) is further manipulated using bits from the data_in. The prmtr_2 state also modifies the synchronization jump width (sjw) using specific bits from the data_in.

**-** Finally, the module transitions to the prmtr_ld_comp state, where it waits for another parameter load signal to return to the prmtr_0 state and repeat the parameter loading process.

![image](https://github.com/Abu20406/Parameter-Registry-Block/assets/68015588/c0dad406-6e4e-4c57-bb88-45f598957e5e)

**The outputs at each of the FSM states are as follows:**

 1.) **idle**:
 
Initial state where all outputs (mask_param, code_param, sjw) are set to zero. No parameter manipulation. Serves as the starting point of the FSM and the state where the FSM returns after completing a parameter loading cycle.

 2.) **prmtr_0**:
 
Stores the least significant 8 bits of data as mask_param the remaining msb bits are concatenated with zeros.code_param and sjw outputs retain their values from the idle state.

 3.) **prmtr_1**:
 
 Modifies the 8-bit mask_param using bits [2:0] of data (mask_param=data_reg[2:0]+mask_param[7:0]). Stores bits [7:3] of data as the least significant 5 bits of code_param remaining MSB bits are concatenated with zeros. sjw output remains unchanged.
 
 4.) **prmtr_2**:
 
 Stores the least significant 6 bits of data as the MSB 6 bits of code_param and the remaining 5 bits of code_param remains the same in the LSB bits. Uses bits [7:6] of data to set the sjw output. Mask_param output remains unchanged.
 
 5.) **prmtr_ld_comp**:
 
 Maintains the outputs (mask_param, code_param, sjw) from the previous state (prmtr_2). FSM waits in this state until the parameter load signal (param_ld) becomes active     
 again. Upon receiving the signal, transitions back to the prmtr_0 state to initiate a new parameter loading cycle.
 
 **Initialization and Reset:**
 
 Upon a global reset (reset), the module sets its internal registers to initial values, and output parameters (mask_param, code_param, sjw) are reset
 to zero. The FSM state is also reset to the idle state on global reset
