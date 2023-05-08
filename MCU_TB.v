module mcu_tb ;
  	parameter op_sz = 32;
    parameter mem_sz=10;
	parameter clk_prd = 10ns;
	reg clk_tb = 0;
	always #(clk_prd/2) clk_tb = ~clk_tb;

	reg reset_tb;
	reg [mem_sz-1 : 0] op0_tb;
	reg [op_sz-1 : 0] op1_tb;
	reg [mem_sz-1 : 0] op2_tb;
	reg [3:0] op_tb;
	wire [op_sz-1 : 0] out_tb;
	wire op_err_tb;

	mcu #( op_sz  , mem_sz) DUT (
	 .clk(clk_tb),
	 .reset(reset_tb),
	 .op0(op0_tb),
	 .op1(op1_tb),													
	 .op2(op2_tb),
	 .op(op_tb), 
	 .out(out_tb),
     .op_err(op_err_tb)
	);
	
	function reg add_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 + data1)) return (1);
      else return (0) ;
	endfunction
	function reg sub_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 - data1)) return (1);
      else return (0) ;
	endfunction
	function reg mult_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 * data1)) return (1);
      else return (0) ;
	endfunction
	function reg div_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 / data1)) return (1);
      else return (0) ;
	endfunction
	function reg AND_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 & data1)) return (1);
      else return (0) ;
	endfunction
	function reg OR_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 | data1)) return (1);
      else return (0) ;
	endfunction
	function reg XOR_check_flag (
      input reg [op_sz-1 : 0] out,
      input reg [op_sz-1 : 0] data0,
      input reg [op_sz-1 : 0] data1
	);
      
      if (out == (data0 ^ data1)) return (1);
      else return (0) ;
	endfunction

	task add0 (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 0; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "addition Output = %d  Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask
	task sub1 (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 1; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
		//check_flag=sub_check_flag(out_tb,data_in0_tb,data_in1_tb);
        $display( "Subtraction Output = %d  Op_error = %d  ",out_tb,op_err_tb);
        reset_tb = 0;
	endtask		
	task mult2(
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 2; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "Multiplication Output = %d        Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask	
	task div3 (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 3; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "Division Output = %d        Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask
	task AND4 (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 4; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "And Output = %d        Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask
	task OR5  (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 5; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "OR Output = %d        Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask	
	task XOR6 (
	input reg [mem_sz-1 : 0] op0,
	input reg [op_sz-1 : 0] op1,
	input reg [mem_sz-1 : 0] op2
	);
		reg check_flag; 
		reset_tb = 0;
		op_tb = 6; 
		op0_tb=op0;
		op1_tb=op1;
		op2_tb = op2;
		#(clk_prd);
        $display( "XOR Output = %d        Op_error = %d",out_tb,op_err_tb);
        reset_tb = 0;
	endtask	
	task read7(
	  input reg [mem_sz-1 : 0] addr
	);
		reset_tb = 0;
		op_tb = 7; 
		op0_tb = addr;
		#(clk_prd);
		$display( "Mem[%d] = %d        Op_error = %d\n",op0_tb,out_tb,op_err_tb);
        reset_tb = 0;
	endtask	
	task write8(
	  input reg [mem_sz-1 : 0] addr_op0,
	  input reg [op_sz-1 : 0] data_op1
	);
		reset_tb=0;
		op_tb = 8; 
		op0_tb = addr_op0;
		op1_tb=data_op1;
		#(clk_prd);
        reset_tb = 0;
	endtask	
	task op_test(
    input reg [3:0] op
  );
    reset_tb=0;
    op_tb = op; 
    #(clk_prd);
    $display("op_error signal =%d\n",op_err_tb);
    endtask
  
	initial begin
	reg[6:0] check_flag;
	check_flag = {{6{0}}};
      write8(3,19);     //mem[3]=19//
	  write8(4,25);	   	//mem[4]=25//
	  
      read7(3);         //read the value of mem[3]//
	  read7(4); 	    //read the value of mem[4]//
	  
	  add0(4,3,6);		// add Mem[4] + mem[3] = mem[6]//
	  check_flag[0]=add_check_flag(out_tb,25,19);
	  $display("add check flag=%d\n",check_flag[0]);
	  
	  sub1(4,3,7);		// sub Mem[4] - mem[3] = mem[7]//
	  check_flag[1]=sub_check_flag(out_tb,25,19);
	  $display("Sub check flag=%d\n",check_flag[1]);
	  
	  mult2(4,3,8);		// mult Mem[4] * mem[3] = mem[8]//
	  check_flag[2]=mult_check_flag(out_tb,25,19);
	  $display("mult check flag=%d\n",check_flag[2]);
	  
	  div3(4,3,9);		// div Mem[4] / mem[3] = mem[9]//
	  check_flag[3]=div_check_flag(out_tb,25,19);
	  $display("Div check flag=%d\n",check_flag[3]);
	  
	  AND4(4,3,10);		// and Mem[4] & mem[3] = mem[10]//
	  check_flag[4]=AND_check_flag(out_tb,25,19);
	  $display("And check flag=%d\n",check_flag[4]);
	  
	  OR5(4,3,11);		// OR Mem[4] | mem[3] = mem[11]//
	  check_flag[5]=OR_check_flag(out_tb,25,19);
	  $display("OR check flag=%d\n",check_flag[5]);	  
	  
	  XOR6(4,3,12);		// XOR Mem[4] ^ mem[3] = mem[12]//
	  check_flag[6]=XOR_check_flag(out_tb,25,19);
	  $display("XOR check flag=%d\n",check_flag[6]);	
	  
      op_test(12);       //op signal = 12//
      $finish();
	end
endmodule
