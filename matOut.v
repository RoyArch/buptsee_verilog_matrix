

module matOut(input wire [63:0] char,
              input wire color,
              input wire clk,
              input wire rst,
              output reg [7:0] row,
              output reg [7:0] col_r,
              output reg [7:0] col_g);

reg [7:0] col;
always@(*)
begin
  if(!color) 
  begin
    col_r=col;
    col_g=8'b0;
  end
  else begin
    col_g=col;
    col_r=8'b0;
  end
end

always@(posedge clk or posedge rst)
begin
  if(rst) row=8'h00;
  else begin
    case(row)
      8'h00:row<=8'h7f;
      8'hfe:row<=8'h7f;
      default:row<={1'b1,row[7:1]};
    endcase
  end
end

reg [3:0] state;
always@(posedge clk or posedge rst)
begin
  if(rst) state<=0;
  else begin
    case(state)
	 4'd0:state<=4'd8;
	 4'd1:state<=4'd8;
	 default:state<=state-4'b1;
	 endcase
  end
end

always@(*)
begin
	if(rst) col=0;
	else begin
		case(state)
		4'd8:col=char[63:56];
		4'd7:col=char[55:48];
		4'd6:col=char[47:40];
		4'd5:col=char[39:32];
		4'd4:col=char[31:24];
		4'd3:col=char[23:16];
		4'd2:col=char[15:8];
		4'd1:col=char[7:0];
		default:col=8'b0;
		endcase
	end
end
endmodule
