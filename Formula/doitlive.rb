class Doitlive < Formula
  include Language::Python::Virtualenv

  desc "Replay stored shell commands for live presentations"
  homepage "https://doitlive.readthedocs.io/en/latest/"
  url "https://files.pythonhosted.org/packages/02/5a/ec8769dc1c6f81939c0f7839b885f27b62b79b67fe69fcc67f347c0dd3ff/doitlive-4.4.0.tar.gz"
  sha256 "1b0031d6ce97778a292b247ccb762fda8212c1b935bc7da6a2be92f677a4ea60"
  license "MIT"
  head "https://github.com/sloria/doitlive.git", branch: "dev"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "605e0c43da1f2889f39fd921c4d5ecaee5091eb8e1c8a15fcf1a5d010809d328"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "93142d964325ca6694d16510a515b2fcce25cd0badfe69c28a9cfc7951214a2c"
    sha256 cellar: :any_skip_relocation, monterey:       "37af56c83002b262848b28842db98e2dc3dd6c54b39f7fca866ec03eb4aa95eb"
    sha256 cellar: :any_skip_relocation, big_sur:        "c7c779c3c9071bceddb9cbed6b6fed3a22c1bc5882660440b19194cfec4a570c"
    sha256 cellar: :any_skip_relocation, catalina:       "f2803c4ae051da368e524c0979d9ea0ec94e812c146092cb95c9c9778c30e5c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48b1bff809153e13b1c9f9d1bb5f5d472893e02d6565422e6de933f0d9e093e9"
  end

  depends_on "python@3.10"
  depends_on "six"

  resource "click" do
    url "https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e/click-7.1.2.tar.gz"
    sha256 "d2b5255c7c6349bc1bd1e59e08cd12acbbd63ce649f2588755783aa94dfb6b1a"
  end

  resource "click-completion" do
    url "https://files.pythonhosted.org/packages/93/18/74e2542defdda23b021b12b835b7abbd0fc55896aa8d77af280ad65aa406/click-completion-0.5.2.tar.gz"
    sha256 "5bf816b81367e638a190b6e91b50779007d14301b3f9f3145d68e3cade7bce86"
  end

  resource "click-didyoumean" do
    url "https://files.pythonhosted.org/packages/2f/a7/822fbc659be70dcb75a91fb91fec718b653326697d0e9907f4f90114b34f/click-didyoumean-0.3.0.tar.gz"
    sha256 "f184f0d851d96b6d29297354ed981b7dd71df7ff500d82fa6d11f0856bee8035"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/71/22/207523d16464c40a0310d2d4d8926daffa00ac1f5b1576170a32db749636/pyparsing-3.0.9.tar.gz"
    sha256 "2b020ecf7d21b687f219b71ecad3631f644a47f01403fa1d1036b0c6416d70fb"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/bd/e6/fdf53ebbf08016dba98f2b047d4db95790157f0e2eed3b14bb5754271475/shellingham-1.5.0.tar.gz"
    sha256 "72fb7f5c63103ca2cb91b23dee0c71fe8ad6fbfd46418ef17dbe40db51592dad"
  end

  def install
    virtualenv_install_with_resources

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, libexec/"bin/doitlive", "completion")
    (bash_completion/"doitlive").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, libexec/"bin/doitlive", "completion")
    (zsh_completion/"_doitlive").write output
  end

  test do
    system "#{bin}/doitlive", "themes", "--preview"
  end
end
