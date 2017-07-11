require 'random_data'

 # Create Posts
 50.times do
   Post.create!(
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 posts = Post.all

 100.times do
   Comment.create!(
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end
puts "#{Post.count}"
Post.find_or_create_by!(title: 'The best day ever!', body: 'We went to the beach today')
puts "#{Post.count}"
puts "#{Comment.count}"
Comment.find_or_create_by!(body: 'So much fun')
puts "#{Comment.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
