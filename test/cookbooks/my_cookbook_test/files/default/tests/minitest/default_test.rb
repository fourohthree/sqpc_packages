require 'minitest/spec'  

install_packages = ['sqpc_packages']['install']
remove_packages = ['sqpc_packages']['remove']

describe_recipe 'sqpc_packages::default' do 

  describe "remove packages" do
    it "removes specified packages" do
      (installed_packages & remove_packages).must_be_empty
    end
  end

  describe "install packages" do
    it "installs specified packages" do
      install_packages.each do |ipkg,version|
        version.must_be_same_as `rpm -qv #{ipkg}`
      end
    end
  end

end
