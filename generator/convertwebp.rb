# convert images to webp
CONVERTERS = {
  'cwebp'          => '-q 80 %s -o %s',
  'magick convert' => '-quality 80 %s %s'
}
converter = CONVERTERS.find { |cmd, params| system("#{cmd} -version") }
Dir.glob('../asset/orig/abra/*.png').each do |image|
  webp_img = '../asset/img/abra/' + File.basename(image).sub('.png', '.webp')
  if converter && !File.exist?(webp_img)
    system("#{converter[0]} #{sprintf(converter[1], image, webp_img)}")
  end
end
