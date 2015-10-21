require 'JSON'
require 'httparty'

def start
  puts "Welcome to your git-hub"
  sleep 1
  puts "Enter your github username:"
    user = gets.chomp
  response = HTTParty.get("https://api.github.com/users/#{user}")
  response.body
  body = JSON.parse response.body

  first_menu(user)
end

def first_menu(user)
  puts <<-EOP
    MENU
    1. REPOS
    2. Followers
    3. Following
  EOP

  answer = gets.chomp.to_i

  case answer
  when 1
    repos(user)
  when 2
    followers(user)
  when 3
    following(user)
  end

end

def repos(user)
  response = HTTParty.get("https://api.github.com/users/#{user}/repos")
  body = JSON.parse response.body
  i = 1
  body.each do |repo|
    puts "#{i}. #{repo['name']}"
    i +=1
  end
end

def followers(user)
  response = HTTParty.get("https://api.github.com/users/#{user}/followers")
  body = JSON.parse response.body
  i = 1
  body.each do |follower|
    puts "#{i}. #{follower['login']}"
    i +=1
  end
end

def following(user)
  response = HTTParty.get("https://api.github.com/users/#{user}/following")
  body = JSON.parse response.body
  i = 1
  body.each do |following|
    puts "#{i}. #{following['login']}"
    i +=1
  end
end


start
