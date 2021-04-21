# convert images to webp
webp_support = system('cwebp')
Dir.glob('../asset/orig/abra/*.png').each do |image|
  webp_img = '../asset/img/abra/' + File.basename(image).sub('.png', '.webp')
  if webp_support && !File.exist?(webp_img)
    system("cwebp -q 80 #{image} -o #{webp_img}")
  end
end
