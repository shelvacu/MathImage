require 'chunky_png'
require 'progress'

filename = ARGV[0]
width = ARGV[1].to_i
height = ARGV[2].to_i || width

def r(x,y)
  (x*x)**(1/2.0)
end

def g(x,y)
  (y*y)**(1/2.0)
end

def b(x,y)
  (x*y)**(1/2.0)
end

error("#{filename} already exists!") if File.exist?(filename)

$img = ChunkyPNG::Image.new(width,height)
width.times.with_progress("Generating image") do |x|
  x = x.to_f
  height.times do |y|
    y = y.to_f
    r = r(x,y).to_i % 256
    g = g(x,y).to_i % 256
    b = b(x,y).to_i % 256
    $img[x,y] = ChunkyPNG::Color.rgb(r,g,b)
  end
end
error("#{filename} already exists!") if File.exist?(filename)
puts 'saving...'
$img.save(filename)
