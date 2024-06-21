module m1;
  semaphore s1;
  bit done1, done2, done3; //done bit to indicate the process completion
  
  task t1();
    $display("@%0d Task t1 started",$time);
    #110;
    $display("@%0d Task t1 finished",$time);
  endtask
  
  task t2();
    $display("@%0d Task t2 started",$time);
    #25;
    $display("@%0d Task t2 finished",$time);
  endtask
  
  task t3();
    $display("@%0d Task t3 started",$time);
    #45;
    $display("@%0d Task t3 finished",$time);
  endtask
  
  initial begin
    s1 = new();
    
    fork
      begin
        t1();
        done1=1;
        s1.put(1);
      end
      begin
        t2();
        done2=1;
        s1.put(1);
      end
      
      begin
        t3();
        done3=1;
        s1.put(1);
      end
      
      begin
        s1.get(2);
        
        if(done1 && done2) begin
          disable t3;
          $display("@%0d Task t3 disabled",$time);
        end

        else if(done2 && done3) begin
          disable t1;
          $display("@%0d Task t1 disabled",$time);
        end
        
        else if(done1 && done3) begin
          disable t2;
          $display("@%0d Task t2 disabled",$time);
        end
        
      end
            
    join

    $display("@%0d Outside fork",$time);    
  end  
  
endmodule
