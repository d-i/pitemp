require 'serialport'

class Arduino

  def initialize debug=false
    @sp = SerialPort.new "/dev/ttyACM0", 9600
    @sp.read_timeout = 1500
    sleep 2
  end

  def get_data
    @sp.flush_input
    @sp.flush_output

    @sp.write " "

    humidity = @sp.readline("\n").chomp
    temp = @sp.readline("\n").chomp

    [humidity, temp]
  end

  def close
    @sp.close
  end

end
