require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DirtyCallbacks" do
  describe "callback before a changed field is saved - on update" do
    before do
      @user = User.create
      User.send :before_email_changed_on_update, :do_stuff
    end

    it "should fire in the before_save_on_update callback if the field has chnaged" do
      @user.email = "whatever"
      @user.expects(:do_stuff)
      @user.send :callback, :before_update
    end

    it "should not fire in the before_save_on_update callback if the field hasn't chnaged" do
      @user.expects(:do_stuff).never
      @user.send :callback, :before_update
    end
  end

  describe "callback after a changed field is saved - on update" do
    before do
      @user = User.create
      User.send :after_email_changed_on_update, :do_stuff
    end

    it "should fire in the after_update callback if the field has chnaged" do
      @user.email = "whatever"
      @user.expects(:do_stuff)
      @user.send :callback, :after_update
    end

    it "should not fire in the after_update callback if the field hasn't chnaged" do
      @user.expects(:do_stuff).never
      @user.send :callback, :after_update
    end
  end
end
