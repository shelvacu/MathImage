require 'RMagick'
require 'progress'
include Magick

error "usage: gif.rb filename.gif <frames> <width> [<height>]" unless ARGV.length.between?(3,4)
filename = ARGV[0]
num_frames = ARGV[1].to_i
width = ARGV[2].to_i
height = ARGV[3] || width
height = height.to_i

def r(x,y,t)
  # x = x/10
  # y = y/10
  # Math.sin(x * y + t / 10) * 200
  (t)+Math.sqrt(x*y)
end
puts "r(1.0,1.0,1.0) = #{r(1.0,1.0,1.0)}"
puts "r(300.0,500.0,33.0) = #{r(300.0,500.0,33.0)}"

def g(x,y,t)
  # x = x/100
  # y = y/100
  # Math.sin(x * y + t / 10) * 200
  (t/2)+Math.sqrt(x*y)
end

def b(x,y,t)
  # Math.sin(x * y + t / 10) * 200
  (t/3)+Math.sqrt(x*y)
end

raise("#{filename} already exists!") if File.exist?(filename)

# $img = ChunkyPNG::Image.new(width,height)
$thingy = (1/256.0)*QuantumRange
threads = []
frames = ImageList.new
puts "starting?"
num_frames.times.with_progress("Making image") do |t|
  #if threads.length >= 4
  #  threads.first.join
  #end
  #threads << Thread.new(t) do |t|
  i = t
  t = t.to_f + 1
  frame = Image.new(width,height)
  width.times do |x|
    x = x.to_f + 1
    height.times do |y|
      y = y.to_f + 1
      r = r(x,y,t).to_i % 256
      g = g(x,y,t).to_i % 256
      b = b(x,y,t).to_i % 256
      r *= $thingy
      g *= $thingy
      b *= $thingy
      puts "white point at #{x},#{y},#{t}" if r == 255 && g == 255 && b==255
      frame.color_point(x,y,Pixel.new(r,g,b,0))
      #puts 'omg' if r == 0 && g == 0 && b == 0
      #frame += [r,g,b]
      #frame << r*256
      #frame << g*256
      #frame << b*256
      # $img[x,y] = ChunkyPNG::Color.rgb(r,g,b)
    end
    #end
    frames[i]= frame
  end
end
=begin
puts "Processing"

final_gif = ImageList.new
frames.each do |frame|
  img = Image.new(width,height)
  img.import_pixels(0,0,width,height,"RGB",frame)
  final_gif << img
end
=end
#raise("#{filename} already exists!") if File.exist?(filename)
puts 'saving...'
frames.write(filename)
