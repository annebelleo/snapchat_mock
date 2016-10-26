require 'pry'

class User
  attr_accessor :username, :email, :phone, :snaps, :followers, :snap_timer_default
  attr_reader :birthday
  attr_writer :password
  def initialize(username, password, email, phone, birthday)
    #attributes (purple)
    @username=username
    @password=password
    @email=email
    @phone=phone
    @birthday=birthday
    @snaps=[]
    @followers=[]
    @snap_timer_default=10
  end

  def send_snap(pic, filter="", geotag="", timer=@snap_timer_default, text="", other_user)
    snap=Snap.new(self, media, filter, geotag, text)
    @snap_timer_default=timer
    if other_user.followers.include?(@username) && @followers.include?(other_user.username)
      other_user.snaps.push(snap)
      else
        "You must be following each other first. Make some friends or something. I don't know"
    end
  end

  def follow(other_user)
    #follow someone
    other_user.followers.push(@username)
  end

  def follow_back(other_user)
    #if you follow someone, they have to follow you back
    @followers.push(other_user.username)
  end

  def unfollow(other_user)
    #unfollow someone
    other_user.followers.pull(@username)
  end
end

class Snap
  attr_accessor :media, :filter, :geotag, :timer, :text
  attr_reader :time, :viewable

  def initialize(user, media, filter="", geotag="", timer=10, text="")
    @user=user
    @media=media
    @filter=filter
    @geotag=geotag
    @timer=user.snap_timer_default
    @text=text
    @time=Time.now
    @viewable=true
  end

  def view_snap
    #check if snap is viewable
    if snap==@viewable && @timer>0
      "show the snap on screen!"
      sleep(@timer)
      puts "snap is now unviewable"
    #change snap to be not viewable once it is viewed
    @viewable=false
    else
      "don't show the snap"
    end
  end
end

#creating new instances of the User class
#taylor instance of the User class
taylor=User.new("twant", "smashword", "camp@kodewithklossy.com", "", "")
#this isn't real data hah

#jeff instance of User class
jeff=User.new("jastornaut", "newsmashword", "email@email.com", "", "")

sofia=User.new("sofia", "ifoewngi", "jiuwfhe", "ouewngfoew", "ioewfhnuf")

snap1=Snap.new(taylor, "cool pic")
binding.pry

#possible next steps: add followers, check to make sure you're following someone before you can send a snap, keep track of who's following you, snapchat score, add filters to your snaps (potentially as a parameter)