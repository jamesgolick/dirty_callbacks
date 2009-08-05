module DirtyCallbacks
  def self.included(klass)
    klass.class_eval do
      columns.each do |f|
        f = f.name
        define_callbacks :"before_#{f}_changes_on_update", :"after_#{f}_changed_on_update"

        before_update do |o|
          o.send :callback, :"before_#{f}_changes_on_update" if o.send :"#{f}_changed?"
        end

        after_update do |o|
          o.send :callback, :"after_#{f}_changed_on_update" if o.send :"#{f}_changed?"
        end
      end
    end
  end
end

