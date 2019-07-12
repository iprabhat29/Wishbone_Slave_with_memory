class wishbone_sequence extends uvm_sequence;
    `uvm_object_utils(wishbone_sequence)
    
    function new(string name = "");
        super.new(name);
    endfunction

    rand logic [31:0] data;
    rand logic [31:0] adr;
    rand bit [1:0] op;
    constraint c0{ 
        solve op before data;
        solve op before adr;                
    }

    constraint c1{
        data inside {[1000:10000]};
        adr inside {[0:255]};
    }

    constraint c2{
        op inside {[0:2]}; 
    }

endclass
