# -*- coding: utf-8 -*-
class Image < ActiveRecord::Base
  belongs_to :imagey, :polymorphic => true
  mount_uploader :the_image, ImageUploader
end
