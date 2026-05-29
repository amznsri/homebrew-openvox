# OpenVox — Homebrew formula for the `amznsri/openvox` tap.
#
# Tap location after publish:
#   https://github.com/amznsri/homebrew-openvox/blob/main/Formula/openvox.rb
#
# Install path for users:
#   brew tap amznsri/openvox
#   brew install openvox
#
# This file is the source of truth in the OpenVox repo. CI copies it
# (with version + sha256 substitutions from the release tag) to the
# tap repo on every tagged release — see .github/workflows/release.yml
# in Phase 4 PR-5.
#
# REGENERATING THE RESOURCE BLOCKS
# ---------------------------------
# Every Python dependency in pyproject.toml needs a `resource` block
# below with a non-empty sha256. The release pipeline regenerates the
# whole block on every tag — you generally don't touch this file by
# hand. To regenerate locally for inspection:
#
#   python -m venv /tmp/openvox-resgen
#   /tmp/openvox-resgen/bin/python -m pip install --upgrade pip
#   /tmp/openvox-resgen/bin/python scripts/gen_homebrew_resources.py \
#       openvox-core==<latest version> > /tmp/resources.rb
#   # Paste /tmp/resources.rb between the BEGIN/END markers below.
#
# We previously used `homebrew-pypi-poet`; it's broken for OpenVox (see
# the script docstring for the two failure modes). The new generator
# uses pip's `--dry-run --report` to resolve the pinned dep set, then
# picks an OS-portable artefact per dep — sdist when available,
# universal `py3-none-any.whl` otherwise, per-OS wheels (in
# `on_macos`/`on_linux` blocks) when neither exists. The output between
# BEGIN/END below may therefore include both top-level `resource`
# blocks and platform-guarded ones — that's expected.
#
# Until the first PyPI release, this formula is a SCAFFOLD — the
# resource list below is intentionally empty. The release-pipeline
# workflow generates the full list automatically as part of the
# publish step.

class Openvox < Formula
  include Language::Python::Virtualenv

  desc "Local-first, open-source voice agent platform"
  homepage "https://github.com/amznsri/openvox"

  # These two lines are rewritten by the release pipeline on every tag.
  # The 0.2.40 + zero-sha placeholders are intentional — they make a
  # mistakenly-tapped pre-release formula fail at the download step
  # rather than silently install a broken build.
  url "https://files.pythonhosted.org/packages/source/o/openvox-core/openvox_core-0.2.40.tar.gz"
  version "0.2.40"
  sha256 "6cb5567134e69f72d6146513915257c9149d6aabfdb2bd9d5d3ea51d6e352b05"

  license "Apache-2.0"
  head "https://github.com/amznsri/openvox.git", branch: "main"

  # Build-time deps come first (brew style enforces alphabetical
  # ordering, but `build`-tagged deps generally lead). With wheel-first
  # resources we don't actually compile the heavy stuff
  # (numpy/cryptography/etc. — those are pre-built per OS). A handful
  # of sdist-only deps (bcrypt declares pkgconf + rust in its PyPI
  # metadata) still need a build toolchain.
  depends_on "pkgconf" => :build
  depends_on "rust" => :build

  depends_on "ffmpeg"             # used by pydub for audio decoding
  depends_on "python@3.12"        # ≥ 3.11 per pyproject; tap defaults to .12

  # ─── BEGIN GENERATED RESOURCES ───
  # ── Per-OS wheels (compiled deps; no source build at install time) ──
  on_macos do
    on_arm do
      resource "aiohttp" do
        url "https://files.pythonhosted.org/packages/29/47/7be41556bfbb6917069d6a6634bb7dd5e163ba445b783a90d40f5ac7e3a7/aiohttp-3.13.5-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "ab2899f9fa2f9f741896ebb6fa07c4c883bfa5c7f2ddd8cf2aafa86fa981b2d2"
      end
      resource "asyncpg" do
        url "https://files.pythonhosted.org/packages/36/01/ffaa189dcb63a2471720615e60185c3f6327716fdc0fc04334436fbb7c65/asyncpg-0.31.0-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "0c89ccf741c067614c9b5fc7f1fc6f3b61ab05ae4aaa966e6fd6b93097c7d20d"
      end
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/df/a2/781b623f57358e360d62cdd7a8c681f074a71d445418a776eef0aadb4ab4/cffi-2.0.0-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "8eca2a813c1cb7ad4fb74d368c2ffbbb4789d377ee5bb8df98373c2cc0dee76c"
      end
      resource "google-crc32c" do
        url "https://files.pythonhosted.org/packages/e9/5f/7307325b1198b59324c0fa9807cafb551afb65e831699f2ce211ad5c8240/google_crc32c-1.8.0-cp312-cp312-macosx_12_0_arm64.whl"
        sha256 "4b8286b659c1335172e39563ab0a768b8015e88e08329fa5321f774275fc3113"
      end
      resource "hiredis" do
        url "https://files.pythonhosted.org/packages/77/4b/35a71d088c6934e162aa81c7e289fa3110a3aca84ab695d88dbd488c74a2/hiredis-3.3.1-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "8e3754ce60e1b11b0afad9a053481ff184d2ee24bea47099107156d1b84a84aa"
      end
      resource "httptools" do
        url "https://files.pythonhosted.org/packages/a5/42/cc4feea2945cb3051038f090c9b36bd5b8a9d7f5a894a506a8983e33fd1c/httptools-0.8.0-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "5931891fb7b441b8a3853cf1b85c82c903defce084dd5f6771ca46e31bf862c5"
      end
      resource "MarkupSafe" do
        url "https://files.pythonhosted.org/packages/9a/81/7e4e08678a1f98521201c3079f77db69fb552acd56067661f8c2f534a718/markupsafe-3.0.3-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "1872df69a4de6aead3491198eaf13810b565bdbeec3ae2dc8780f14458ec73ce"
      end
      resource "numpy" do
        url "https://files.pythonhosted.org/packages/ea/12/92c4c131527599e8288d6918e888d88726f84d805d784b771f32408aeaef/numpy-2.4.6-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "ebfb099f8dcf083deef3ac1ca4c1503f387cf76296fcb3816b66f5ecb5f54fdb"
      end
      resource "orjson" do
        url "https://files.pythonhosted.org/packages/24/75/05912954c8b288f34fcf5cd4b9b071cb4f6e77b9961e175e56ebb258089f/orjson-3.11.9-cp312-cp312-macosx_15_0_arm64.whl"
        sha256 "e5c9b8f28e726e97d97696c826bc7bea5d71cecd63576dba92924a32c1961291"
      end
      resource "pydantic_core" do
        url "https://files.pythonhosted.org/packages/19/95/6195171e385007300f0f5574592e467c568becce2d937a0b6804f218bc49/pydantic_core-2.46.4-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "962ccbab7b642487b1d8b7df90ef677e03134cf1fd8880bf698649b22a69371f"
      end
      resource "PyYAML" do
        url "https://files.pythonhosted.org/packages/89/a0/6cf41a19a1f2f3feab0e9c0b74134aa2ce6849093d5517a0c550fe37a648/pyyaml-6.0.3-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "fc09d0aa354569bc501d4e787133afc08552722d3ab34836a80547331bb5d4a0"
      end
      resource "rpds-py" do
        url "https://files.pythonhosted.org/packages/a3/43/35e3f136343aef451e545ce8c38d36c2f93c0ed88703db8b64ba2b205c68/rpds_py-2026.5.1-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "58b1d94308ddf0b1982f61f2eb54bf92997c9ece8a8093ef014250f4a517906c"
      end
      resource "watchfiles" do
        url "https://files.pythonhosted.org/packages/5f/8f/6af2ea19065c91d8b0ea3516fdfc8c0d349f407e8e9fbf4e5a17360de8ad/watchfiles-1.2.0-cp312-cp312-macosx_11_0_arm64.whl"
        sha256 "2d95ddc1eb6914154253d239089900813f6a767e174b8e6a50e7fdacb7e4236c"
      end
    end
    on_intel do
      resource "aiohttp" do
        url "https://files.pythonhosted.org/packages/be/6f/353954c29e7dcce7cf00280a02c75f30e133c00793c7a2ed3776d7b2f426/aiohttp-3.13.5-cp312-cp312-macosx_10_13_universal2.whl"
        sha256 "023ecba036ddd840b0b19bf195bfae970083fd7024ce1ac22e9bba90464620e9"
      end
      resource "asyncpg" do
        url "https://files.pythonhosted.org/packages/2a/a6/59d0a146e61d20e18db7396583242e32e0f120693b67a8de43f1557033e2/asyncpg-0.31.0-cp312-cp312-macosx_10_13_x86_64.whl"
        sha256 "b44c31e1efc1c15188ef183f287c728e2046abb1d26af4d20858215d50d91fad"
      end
      resource "bcrypt" do
        url "https://files.pythonhosted.org/packages/84/29/6237f151fbfe295fe3e074ecc6d44228faa1e842a81f6d34a02937ee1736/bcrypt-5.0.0-cp38-abi3-macosx_10_12_universal2.whl"
        sha256 "fc746432b951e92b58317af8e0ca746efe93e66555f1b40888865ef5bf56446b"
      end
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/ea/47/4f61023ea636104d4f16ab488e268b93008c3d0bb76893b1b31db1f96802/cffi-2.0.0-cp312-cp312-macosx_10_13_x86_64.whl"
        sha256 "6d02d6655b0e54f54c4ef0b94eb6be0607b70853c45ce98bd278dc7de718be5d"
      end
      resource "cryptography" do
        url "https://files.pythonhosted.org/packages/df/3d/01f6dd9190170a5a241e0e98c2d04be3664a9e6f5b9b872cde63aff1c3dd/cryptography-48.0.0-cp311-abi3-macosx_10_9_universal2.whl"
        sha256 "0c558d2cdffd8f4bbb30fc7134c74d2ca9a476f830bb053074498fbc86f41ed6"
      end
      resource "google-crc32c" do
        url "https://files.pythonhosted.org/packages/21/8e/58c0d5d86e2220e6a37befe7e6a94dd2f6006044b1a33edf1ff6d9f7e319/google_crc32c-1.8.0-cp312-cp312-macosx_12_0_x86_64.whl"
        sha256 "2a3dc3318507de089c5384cc74d54318401410f82aa65b2d9cdde9d297aca7cb"
      end
      resource "greenlet" do
        url "https://files.pythonhosted.org/packages/c4/37/4549f149c9797c21b32c2683c33522af22522099de128b2406672526d005/greenlet-3.5.1-cp312-cp312-macosx_11_0_universal2.whl"
        sha256 "fa4f98af3a528f0c3fd592a26df7f376f93329c8f4d987f6bb979057af8bf5e2"
      end
      resource "hiredis" do
        url "https://files.pythonhosted.org/packages/b3/1d/1a7d925d886211948ab9cca44221b1d9dd4d3481d015511e98794e37d369/hiredis-3.3.1-cp312-cp312-macosx_10_15_universal2.whl"
        sha256 "60543f3b068b16a86e99ed96b7fdae71cdc1d8abdfe9b3f82032a555e52ece7e"
      end
      resource "httptools" do
        url "https://files.pythonhosted.org/packages/14/88/1d21a36da8f5cb0fa49eafd4b169eba5608d57e75bbcf61845cbc6243216/httptools-0.8.0-cp312-cp312-macosx_10_13_universal2.whl"
        sha256 "880490234c10f70a9830743097e8958d6e4b9f5a0ffc24515023afeef984054d"
      end
      resource "MarkupSafe" do
        url "https://files.pythonhosted.org/packages/5a/72/147da192e38635ada20e0a2e1a51cf8823d2119ce8883f7053879c2199b5/markupsafe-3.0.3-cp312-cp312-macosx_10_13_x86_64.whl"
        sha256 "d53197da72cc091b024dd97249dfc7794d6a56530370992a5e1a08983ad9230e"
      end
      resource "numpy" do
        url "https://files.pythonhosted.org/packages/95/2a/3d7b5ac8aac24feaf9ad7ed58f45b0bbc06d37e4338ae84c9f2298b570f9/numpy-2.4.6-cp312-cp312-macosx_10_13_x86_64.whl"
        sha256 "001fbb8e08d942dd57599e781f2472269ee7f2755fae407b4f67b2f0b17da3f1"
      end
      resource "orjson" do
        url "https://files.pythonhosted.org/packages/16/6d/11867a3ffa3a3608d84a4de51ef4dd0896d6b5cc9132fbe1daf593e677bc/orjson-3.11.9-cp312-cp312-macosx_10_15_x86_64.macosx_11_0_arm64.macosx_10_15_universal2.whl"
        sha256 "9ef6fe90aadef185c7b128859f40beb24720b4ecea95379fc9000931179c3a49"
      end
      resource "pycryptodome" do
        url "https://files.pythonhosted.org/packages/db/6c/a1f71542c969912bb0e106f64f60a56cc1f0fabecf9396f45accbe63fa68/pycryptodome-3.23.0-cp37-abi3-macosx_10_9_universal2.whl"
        sha256 "187058ab80b3281b1de11c2e6842a357a1f71b42cb1e15bce373f3d238135c27"
      end
      resource "pydantic_core" do
        url "https://files.pythonhosted.org/packages/ce/8c/af022f0af448d7747c5154288d46b5f2bc5f17366eaa0e23e9aa04d59f3b/pydantic_core-2.46.4-cp312-cp312-macosx_10_12_x86_64.whl"
        sha256 "3245406455a5d98187ec35530fd772b1d799b26667980872c8d4614991e2c4a2"
      end
      resource "PyYAML" do
        url "https://files.pythonhosted.org/packages/d1/33/422b98d2195232ca1826284a76852ad5a86fe23e31b009c9886b2d0fb8b2/pyyaml-6.0.3-cp312-cp312-macosx_10_13_x86_64.whl"
        sha256 "7f047e29dcae44602496db43be01ad42fc6f1cc0d8cd6c83d342306c32270196"
      end
      resource "rpds-py" do
        url "https://files.pythonhosted.org/packages/d4/e7/a78582dc57caa592dcc7d4fb69b61390561e908eb3d2f5df5928a8e354c0/rpds_py-2026.5.1-cp312-cp312-macosx_10_12_x86_64.whl"
        sha256 "3abe24a66e57adcfa645d718063a5fa5103ecc71ddbf26d78af8f9368018ff1d"
      end
      resource "uvloop" do
        url "https://files.pythonhosted.org/packages/3d/ff/7f72e8170be527b4977b033239a83a68d5c881cc4775fca255c677f7ac5d/uvloop-0.22.1-cp312-cp312-macosx_10_13_universal2.whl"
        sha256 "fe94b4564e865d968414598eea1a6de60adba0c040ba4ed05ac1300de402cd42"
      end
      resource "watchfiles" do
        url "https://files.pythonhosted.org/packages/b8/2f/e42c992d2afda3108ea1c02acecc991b9f31d05c14adc2a7cee9ee211fc4/watchfiles-1.2.0-cp312-cp312-macosx_10_12_x86_64.whl"
        sha256 "bc13eb17538be00c874699dc0abe4ee2bc8d50bb1166a6b9e175ef3fd7eb8f26"
      end
    end
  end
  on_linux do
    on_intel do
      resource "aiohttp" do
        url "https://files.pythonhosted.org/packages/57/d8/8d44036d7eb7b6a8ec4c5494ea0c8c8b94fbc0ed3991c1a7adf230df03bf/aiohttp-3.13.5-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "b18f31b80d5a33661e08c89e202edabf1986e9b49c42b4504371daeaa11b47c1"
      end
      resource "asyncpg" do
        url "https://files.pythonhosted.org/packages/8c/d1/a867c2150f9c6e7af6462637f613ba67f78a314b00db220cd26ff559d532/asyncpg-0.31.0-cp312-cp312-manylinux_2_28_x86_64.whl"
        sha256 "aad7a33913fb8bcb5454313377cc330fbb19a0cd5faa7272407d8a0c4257b671"
      end
      resource "bcrypt" do
        url "https://files.pythonhosted.org/packages/3b/71/427945e6ead72ccffe77894b2655b695ccf14ae1866cd977e185d606dd2f/bcrypt-5.0.0-cp38-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "560ddb6ec730386e7b3b26b8b4c88197aaed924430e7b74666a586ac997249ef"
      end
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/78/2d/7fa73dfa841b5ac06c7b8855cfc18622132e365f5b81d02230333ff26e9e/cffi-2.0.0-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "3e17ed538242334bf70832644a32a7aae3d83b57567f9fd60a26257e992b79ba"
      end
      resource "cryptography" do
        url "https://files.pythonhosted.org/packages/90/04/673510ed51ddff56575f306cf1617d80411ee76831ccd3097599140efdfe/cryptography-48.0.0-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "7995ef305d7165c3f11ae07f2517e5a4f1d5c18da1376a0a9ed496336b69e5f3"
      end
      resource "google-crc32c" do
        url "https://files.pythonhosted.org/packages/ce/a9/a780cc66f86335a6019f557a8aaca8fbb970728f0efd2430d15ff1beae0e/google_crc32c-1.8.0-cp312-cp312-manylinux1_x86_64.manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_5_x86_64.whl"
        sha256 "14f87e04d613dfa218d6135e81b78272c3b904e2a7053b841481b38a7d901411"
      end
      resource "greenlet" do
        url "https://files.pythonhosted.org/packages/40/69/b91cda0647df839483201545913514c2827ebea5e5ccdf931842763bc127/greenlet-3.5.1-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "add5217d68b31130f0beca584d7fef4878327d2e31642b66618a14eef312b63b"
      end
      resource "hiredis" do
        url "https://files.pythonhosted.org/packages/52/3a/859afe2620666bf6d58eb977870c47d98af4999d473b50528b323918f3f7/hiredis-3.3.1-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "c25132902d3eff38781e0d54f27a0942ec849e3c07dbdce83c4d92b7e43c8dce"
      end
      resource "httptools" do
        url "https://files.pythonhosted.org/packages/e3/a6/febbb8b8db0f58b38e44ad6cb946e6a255ae49b55f2e8543408fb7501ccd/httptools-0.8.0-cp312-cp312-manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64.whl"
        sha256 "b15fc622b0f869d19207c4089a501d9bcc63ca5e071ffdd2f03f922df882dcb2"
      end
      resource "MarkupSafe" do
        url "https://files.pythonhosted.org/packages/3c/2e/8d0c2ab90a8c1d9a24f0399058ab8519a3279d1bd4289511d74e909f060e/markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "d6dd0be5b5b189d31db7cda48b91d7e0a9795f31430b7f271219ab30f1d3ac9d"
      end
      resource "numpy" do
        url "https://files.pythonhosted.org/packages/99/60/14115e6364fa676c5397c2ad3004e527e9aa487abf5d0706ec81bbd08529/numpy-2.4.6-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "90f9849678c75fe7afa2d348ac842c168b0a4d3d61919687216dfc547976d853"
      end
      resource "orjson" do
        url "https://files.pythonhosted.org/packages/0e/a4/82b7a2fe5d8a67a59ed831b24d59a3d46ea7d207b66e1602d376541d94a6/orjson-3.11.9-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "be4fa4f0af7fa18951f7ab3fc2148e223af211bf03f59e1c6034ec3f97f21d61"
      end
      resource "pycryptodome" do
        url "https://files.pythonhosted.org/packages/5f/e9/a09476d436d0ff1402ac3867d933c61805ec2326c6ea557aeeac3825604e/pycryptodome-3.23.0-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "c8987bd3307a39bc03df5c8e0e3d8be0c4c3518b7f044b0f4c15d1aa78f52575"
      end
      resource "pydantic_core" do
        url "https://files.pythonhosted.org/packages/5f/97/2aab507d3d00ca626e8e57c1eac6a79e4e5fbcc63eb99733ff55d1717f65/pydantic_core-2.46.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "926c9541b14b12b1681dca8a0b75feb510b06c6341b70a8e500c2fdcff837cce"
      end
      resource "PyYAML" do
        url "https://files.pythonhosted.org/packages/8b/9d/b3589d3877982d4f2329302ef98a8026e7f4443c765c46cfecc8858c6b4b/pyyaml-6.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "ba1cc08a7ccde2d2ec775841541641e4548226580ab850948cbfda66a1befcdc"
      end
      resource "rpds-py" do
        url "https://files.pythonhosted.org/packages/f4/1e/2c9096fc19d5fd084b0184ca2b651e659aa0a37e6fdbecf6ece47f147fe1/rpds_py-2026.5.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "b6825cc329b290e93c5f6a9be2393118a763f6ccf6abd83704e0c102ca583644"
      end
      resource "uvloop" do
        url "https://files.pythonhosted.org/packages/5f/6f/e62b4dfc7ad6518e7eff2516f680d02a0f6eb62c0c212e152ca708a0085e/uvloop-0.22.1-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "7b5b1ac819a3f946d3b2ee07f09149578ae76066d70b44df3fa990add49a82e4"
      end
      resource "watchfiles" do
        url "https://files.pythonhosted.org/packages/22/24/ed72f68cbc1333ca9b9f2200aa048bb6658ae41709bc1caad4310f4bdffd/watchfiles-1.2.0-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "e53a384f76b631c3ae5334ce6a52f0baa3a911eb94a4eac7f160079868b716d5"
      end
    end
    on_arm do
      resource "aiohttp" do
        url "https://files.pythonhosted.org/packages/67/84/c9ecc5828cb0b3695856c07c0a6817a99d51e2473400f705275a2b3d9239/aiohttp-3.13.5-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "a60eaa2d440cd4707696b52e40ed3e2b0f73f65be07fd0ef23b6b539c9c0b0b4"
      end
      resource "asyncpg" do
        url "https://files.pythonhosted.org/packages/9f/62/3f699ba45d8bd24c5d65392190d19656d74ff0185f42e19d0bbd973bb371/asyncpg-0.31.0-cp312-cp312-manylinux_2_28_aarch64.whl"
        sha256 "12b3b2e39dc5470abd5e98c8d3373e4b1d1234d9fbdedf538798b2c13c64460a"
      end
      resource "bcrypt" do
        url "https://files.pythonhosted.org/packages/45/b6/4c1205dde5e464ea3bd88e8742e19f899c16fa8916fb8510a851fae985b5/bcrypt-5.0.0-cp38-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "c2388ca94ffee269b6038d48747f4ce8df0ffbea43f31abfa18ac72f0218effb"
      end
      resource "cffi" do
        url "https://files.pythonhosted.org/packages/d5/72/12b5f8d3865bf0f87cf1404d8c374e7487dcf097a1c91c436e72e6badd83/cffi-2.0.0-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "b21e08af67b8a103c71a250401c78d5e0893beff75e28c53c98f4de42f774062"
      end
      resource "cryptography" do
        url "https://files.pythonhosted.org/packages/b2/6e/e90527eef33f309beb811cf7c982c3aeffcce8e3edb178baa4ca3ae4a6fa/cryptography-48.0.0-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "f5333311663ea94f75dd408665686aaf426563556bb5283554a3539177e03b8c"
      end
      resource "google-crc32c" do
        url "https://files.pythonhosted.org/packages/21/3f/3457ea803db0198c9aaca2dd373750972ce28a26f00544b6b85088811939/google_crc32c-1.8.0-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "cb5c869c2923d56cb0c8e6bcdd73c009c36ae39b652dbe46a05eb4ef0ad01454"
      end
      resource "greenlet" do
        url "https://files.pythonhosted.org/packages/38/ff/a4f436709716965eaab9f36ea7b906c8a927fbe32fb1372a2071d964f6b1/greenlet-3.5.1-cp312-cp312-manylinux_2_24_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "ffea73584b216150eab159b6d12348fb253e68757974de1e2c40d8a318ac89ed"
      end
      resource "hiredis" do
        url "https://files.pythonhosted.org/packages/1f/54/904bc723a95926977764fefd6f0d46067579bac38fffc32b806f3f2c05c0/hiredis-3.3.1-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "e89dabf436ee79b358fd970dcbed6333a36d91db73f27069ca24a02fb138a404"
      end
      resource "httptools" do
        url "https://files.pythonhosted.org/packages/b7/e4/f90a0df0b83beff265b7e3b65f2a4cefd95792d4be0ac3e16049f2acd3c2/httptools-0.8.0-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "425f83884fd6343828d8c565f046cb72b6d19063f6924093e11bcd8e1548cd09"
      end
      resource "MarkupSafe" do
        url "https://files.pythonhosted.org/packages/1e/2c/799f4742efc39633a1b54a92eec4082e4f815314869865d876824c257c1e/markupsafe-3.0.3-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "3a7e8ae81ae39e62a41ec302f972ba6ae23a5c5396c8e60113e9066ef893da0d"
      end
      resource "numpy" do
        url "https://files.pythonhosted.org/packages/c9/c6/50a46a6205feba2343f1d6d17438107c5dc491ed1c736e6ea68689fd906b/numpy-2.4.6-cp312-cp312-manylinux_2_27_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "5f9fb9157b4ce2971008323afe46053787b526ef624fea915b261468a8421a0f"
      end
      resource "orjson" do
        url "https://files.pythonhosted.org/packages/ab/86/1c3a47df3bc8191ea9ac51603bbb872a95167a364320c269f2557911f406/orjson-3.11.9-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "26a473dbb4162108b27901492546f83c76fdcea3d0eadff00ae7a07e18dcce09"
      end
      resource "pycryptodome" do
        url "https://files.pythonhosted.org/packages/50/52/adaf4c8c100a8c49d2bd058e5b551f73dfd8cb89eb4911e25a0c469b6b4e/pycryptodome-3.23.0-cp37-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "67bd81fcbe34f43ad9422ee8fd4843c8e7198dd88dd3d40e6de42ee65fbe1490"
      end
      resource "pydantic_core" do
        url "https://files.pythonhosted.org/packages/8e/bc/f47d1ff9cbb1620e1b5b697eef06010035735f07820180e74178226b27b3/pydantic_core-2.46.4-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "8233f2947cf85404441fd7e0085f53b10c93e0ee78611099b5c7237e36aacbf7"
      end
      resource "PyYAML" do
        url "https://files.pythonhosted.org/packages/ed/23/7a778b6bd0b9a8039df8b1b1d80e2e2ad78aa04171592c8a5c43a56a6af4/pyyaml-6.0.3-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "9149cad251584d5fb4981be1ecde53a1ca46c891a79788c0df828d2f166bda28"
      end
      resource "rpds-py" do
        url "https://files.pythonhosted.org/packages/20/e1/0f2160c5982d3157734d5cb3ed63d8b2d583a73c9864f77b666449f32cf8/rpds_py-2026.5.1-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "0fa92420128dadce7f54bd73ba1825a273e9268fe9e35dbf7e6362890efa4e08"
      end
      resource "uvloop" do
        url "https://files.pythonhosted.org/packages/24/68/a6ac446820273e71aa762fa21cdcc09861edd3536ff47c5cd3b7afb10eeb/uvloop-0.22.1-cp312-cp312-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "700e674a166ca5778255e0e1dc4e9d79ab2acc57b9171b79e65feba7184b3370"
      end
      resource "watchfiles" do
        url "https://files.pythonhosted.org/packages/13/01/b32a967c56fb3e3e5be3db52c3d3b87fa4513aa367d8ed1ad96d42952e5f/watchfiles-1.2.0-cp312-cp312-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "8f70d8b291ef6e88d19b1f297a6905ddb978888d9272b0d05e6f53309856bcfc"
      end
    end
  end

  # ── Universal wheels (pure-Python, one URL for every OS) ───────────
  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/bc/8a/340a1555ae33d7354dbca4faa54948d76d89a27ceef032c8c3bc661d003e/aiofiles-25.1.0-py3-none-any.whl"
    sha256 "abe311e527c862958650f9438e859c1fa7568a141b22abcd015e120e86a85695"
  end
  resource "aiohappyeyeballs" do
    url "https://files.pythonhosted.org/packages/5f/fc/a7bf5b6e4e617b45f90f2d9d2a68519c249c81dd4fc2658c7a2a61c4f4b7/aiohappyeyeballs-2.6.2-py3-none-any.whl"
    sha256 "4708045e2d7a6c6bdf8aafa8ed39649eaf926a4543b54560659129e3365953c4"
  end
  resource "aiohttp-retry" do
    url "https://files.pythonhosted.org/packages/1a/99/84ba7273339d0f3dfa57901b846489d2e5c2cd731470167757f1935fffbd/aiohttp_retry-2.9.1-py3-none-any.whl"
    sha256 "66d2759d1921838256a05a3f80ad7e724936f083e35be5abb5e16eed6be6dc54"
  end
  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/fb/76/641ae371508676492379f16e2fa48f4e2c11741bd63c48be4b12a6b09cba/aiosignal-1.4.0-py3-none-any.whl"
    sha256 "053243f8b92b990551949e63930a839ff0cf0b0ebbe0597b0f3fb19e1a0fe82e"
  end
  resource "aiosqlite" do
    url "https://files.pythonhosted.org/packages/00/b7/e3bf5133d697a08128598c8d0abc5e16377b51465a33756de24fa7dee953/aiosqlite-0.22.1-py3-none-any.whl"
    sha256 "21c002eb13823fad740196c5a2e9d8e62f6243bd9e7e4a1f87fb5e44ecb4fceb"
  end
  resource "alembic" do
    url "https://files.pythonhosted.org/packages/d2/29/6533c317b74f707ea28f8d633734dbda2119bbadfc61b2f3640ba835d0f7/alembic-1.18.4-py3-none-any.whl"
    sha256 "a5ed4adcf6d8a4cb575f3d759f071b03cd6e5c7618eb796cb52497be25bfe19a"
  end
  resource "aliyun-python-sdk-kms" do
    url "https://files.pythonhosted.org/packages/11/5c/0132193d7da2c735669a1ed103b142fd63c9455984d48c5a88a1a516efaa/aliyun_python_sdk_kms-2.16.5-py2.py3-none-any.whl"
    sha256 "24b6cdc4fd161d2942619479c8d050c63ea9cd22b044fe33b60bbb60153786f0"
  end
  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/1e/d3/26bf1008eb3d2daa8ef4cacc7f3bfdc11818d111f7e2d0201bc6e3b49d45/annotated_doc-0.0.4-py3-none-any.whl"
    sha256 "571ac1dc6991c450b25a9c2d84a3705e2ae7a53467b5d111c24fa8baabbed320"
  end
  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/78/b6/6307fbef88d9b5ee7421e68d78a9f162e0da4900bc5f5793f6d3d0e34fb8/annotated_types-0.7.0-py3-none-any.whl"
    sha256 "1f02e8b43a8fbbc3f3e0d4f0f4bfc8131bcb4eebe8849b8e5c773f3a1c582a53"
  end
  resource "anyio" do
    url "https://files.pythonhosted.org/packages/da/42/e921fccf5015463e32a3cf6ee7f980a6ed0f395ceeaa45060b61d86486c2/anyio-4.13.0-py3-none-any.whl"
    sha256 "08b310f9e24a9594186fd75b4f73f4a4152069e3853f1ed8bfbf58369f4ad708"
  end
  resource "APScheduler" do
    url "https://files.pythonhosted.org/packages/9f/64/2e54428beba8d9992aa478bb8f6de9e4ecaa5f8f513bcfd567ed7fb0262d/apscheduler-3.11.2-py3-none-any.whl"
    sha256 "ce005177f741409db4e4dd40a7431b76feb856b9dd69d57e0da49d6715bfd26d"
  end
  resource "asgiref" do
    url "https://files.pythonhosted.org/packages/5c/0a/a72d10ed65068e115044937873362e6e32fab1b7dce0046aeb224682c989/asgiref-3.11.1-py3-none-any.whl"
    sha256 "e8667a091e69529631969fd45dc268fa79b99c92c5fcdda727757e52146ec133"
  end
  resource "attrs" do
    url "https://files.pythonhosted.org/packages/64/b4/17d4b0b2a2dc85a6df63d1157e028ed19f90d4cd97c36717afef2bc2f395/attrs-26.1.0-py3-none-any.whl"
    sha256 "c647aa4a12dfbad9333ca4e71fe62ddc36f4e63b2d260a37a8b83d2f043ac309"
  end
  resource "Authlib" do
    url "https://files.pythonhosted.org/packages/fb/95/adcb68e20c34162e9135f370d6e31737719c2b6f94bc953fe7ed1f10fe21/authlib-1.7.2-py2.py3-none-any.whl"
    sha256 "3e1faedc9d87e7d56a164eca3ccb6ace0d61b94abe83e92242f8dc8bba9b4a9f"
  end
  resource "boto3" do
    url "https://files.pythonhosted.org/packages/f9/1e/30b218998dee295873f33c591bb5daf08c42ec27e5fb0ebb13977677e96f/boto3-1.43.17-py3-none-any.whl"
    sha256 "f6b3862a0b14e237f9323223ee76b0563e87a6bbe6d94a42e7b008a901ba8950"
  end
  resource "botocore" do
    url "https://files.pythonhosted.org/packages/d6/ff/1625713b2ecac9f9bb65c7a51e71cb206b3089ba38f86ba5eff34e947176/botocore-1.43.17-py3-none-any.whl"
    sha256 "499af7c942ecfd404322974e82c6b5d05a8ea16e9f19320b353e16f401adc5b4"
  end
  resource "certifi" do
    url "https://files.pythonhosted.org/packages/59/8c/57e832b7af6d7c5abe66eb3fbe3a3a32f4d11ea23a1aa7131371035be991/certifi-2026.5.20-py3-none-any.whl"
    sha256 "3c52e209ba0a4ad7aebe60436a4ab349c39e1e602e8c134221e546902ad25897"
  end
  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/db/8f/61959034484a4a7c527811f4721e75d02d653a35afb0b6054474d8185d4c/charset_normalizer-3.4.7-py3-none-any.whl"
    sha256 "3dce51d0f5e7951f8bb4900c257dad282f49190fdbebecd4ba99bcc41fef404d"
  end
  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0d/67e5b4109ea4a837e80daa87c2c696711955e40449a97e8926672534def2/click-8.4.1-py3-none-any.whl"
    sha256 "482be17c6991b8c19c5429a1e995d9b0efdbb63172824c41f99965dc0ade8ec2"
  end
  resource "Deprecated" do
    url "https://files.pythonhosted.org/packages/84/d0/205d54408c08b13550c733c4b85429e7ead111c7f0014309637425520a9a/deprecated-1.3.1-py2.py3-none-any.whl"
    sha256 "597bfef186b6f60181535a29fbe44865ce137a5079f295b479886c82729d5f3f"
  end
  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/51/79/119091c98e2bf49e24ed9f3ae69f816d715d2904aefa6a2baa039a2ba0b0/ecdsa-0.19.2-py2.py3-none-any.whl"
    sha256 "840f5dc5e375c68f36c1a7a5b9caad28f95daa65185c9253c0c08dd952bb7399"
  end
  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/e0/82/45359b62a067409bd929ae8a56b8ed13e5a8c8a61194b3c236920999ab83/fastapi-0.136.3-py3-none-any.whl"
    sha256 "3d2a69bdf04b7e9f3afa292c3bc7a98816bbfafa10bc9b45f3f3700d2f761620"
  end
  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/9a/9a/e35b4a917281c0b8419d4207f4334c8e8c5dbf4f3f5f9ada73958d937dcc/frozenlist-1.8.0-py3-none-any.whl"
    sha256 "0c18a16eab41e82c295618a77502e17b195883241c563b00f0aa5106fc4eaa0d"
  end
  resource "google-api-core" do
    url "https://files.pythonhosted.org/packages/03/15/e56f351cf6ef1cfea58e6ac226a7318ed1deb2218c4b3cc9bd9e4b786c5a/google_api_core-2.30.3-py3-none-any.whl"
    sha256 "a85761ba72c444dad5d611c2220633480b2b6be2521eca69cca2dbb3ffd6bfe8"
  end
  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/4a/c9/db44165ba7c581268c6d46017ef63339110378305062830104fc7fa144cb/google_auth-2.53.0-py3-none-any.whl"
    sha256 "6e7449917c599b35126a99ec268ec6880301f2fea41dce198fe8fd83ff642b68"
  end
  resource "google-cloud-core" do
    url "https://files.pythonhosted.org/packages/84/4a/98da8930ab109c73d9a5d13782a9ebb81ea8c111f6d534a567b71d23e52b/google_cloud_core-2.6.0-py3-none-any.whl"
    sha256 "6d63ac8e5eca6d9e4319d0a1e2265fadcd7f1049904378caecfa01cf52dd869e"
  end
  resource "google-cloud-storage" do
    url "https://files.pythonhosted.org/packages/ad/ff/ca9ab2417fa913d75aae38bf40bf856bb2749a604b2e0f701b37cfcd23cc/google_cloud_storage-3.10.1-py3-none-any.whl"
    sha256 "a72f656759b7b99bda700f901adcb3425a828d4a29f911bc26b3ea79c5b1217f"
  end
  resource "google-resumable-media" do
    url "https://files.pythonhosted.org/packages/07/73/3518e63deb1667c5409a4579e28daf5e84479a87a72c547e0487f7883dcd/google_resumable_media-2.9.0-py3-none-any.whl"
    sha256 "c8901e88e389af8bed64d9696c74d8bad961865eb2236e13e0bfca9bb0a65ca3"
  end
  resource "googleapis-common-protos" do
    url "https://files.pythonhosted.org/packages/e7/c8/e2645aa8ed02fd4c7a2f59d68783b65b1f3cbdfe39a6308e156509d1fee8/googleapis_common_protos-1.75.0-py3-none-any.whl"
    sha256 "961ed60399c457ceb0ee8f285a84c870aabc9c6a832b9d37bb281b5bebde43ed"
  end
  resource "h11" do
    url "https://files.pythonhosted.org/packages/04/4b/29cac41a4d98d144bf5f6d33995617b185d14b22401f75ca86f384e87ff1/h11-0.16.0-py3-none-any.whl"
    sha256 "63cf8bbe7522de3bf65932fda1d9c2772064ffb3dae62d55932da54b31cb6c86"
  end
  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/7e/f5/f66802a942d491edb555dd61e3a9961140fd64c90bce1eafd741609d334d/httpcore-1.0.9-py3-none-any.whl"
    sha256 "2d400746a40668fc9dec9810239072b40b4484b640a8c38fd654a024c7a1bf55"
  end
  resource "httpx" do
    url "https://files.pythonhosted.org/packages/2a/39/e50c7c3a983047577ee07d2a9e53faf5a69493943ec3f6a384bdc792deb2/httpx-0.28.1-py3-none-any.whl"
    sha256 "d909fcccc110f8c7faf814ca82a9a4d816bc5a6dbfea25d6591d6985b8ba59ad"
  end
  resource "httpx-sse" do
    url "https://files.pythonhosted.org/packages/d2/fd/6668e5aec43ab844de6fc74927e155a3b37bf40d7c3790e49fc0406b6578/httpx_sse-0.4.3-py3-none-any.whl"
    sha256 "0ac1c9fe3c0afad2e0ebb25a934a59f4c7823b60792691f779fad2c5568830fc"
  end
  resource "idna" do
    url "https://files.pythonhosted.org/packages/de/a7/f76514cc40ad6234098ecdebda08732d75964776c51a42845b7da10649e2/idna-3.17-py3-none-any.whl"
    sha256 "466e48829084efe2548012b855df21540b96f2e20e51bd124c851536556a592c"
  end
  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/07/cb/5f001272b6faeb23c1c9e0acc04d48eaaf5c862c17709d20e3469c6e0139/jmespath-0.10.0-py2.py3-none-any.whl"
    sha256 "cdf6525904cc597730141d61b36f2e4b8ecc257c420fa2f4549bac2c2d0cb72f"
  end
  resource "joserfc" do
    url "https://files.pythonhosted.org/packages/98/8c/5cdce2cf3ce8155849baf9a5e2ce77e89dc87ec3bdb38259e5d85fbc45bd/joserfc-1.6.8-py3-none-any.whl"
    sha256 "22fb31a69094a5e6f44632002a9df2c30c941fc6c8ce1b037e92c03de954cf9f"
  end
  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/69/90/f63fb5873511e014207a475e2bb4e8b2e570d655b00ac19a9a0ca0a385ee/jsonschema-4.26.0-py3-none-any.whl"
    sha256 "d489f15263b8d200f8387e64b4c3a75f06629559fb73deb8fdfb525f2dab50ce"
  end
  resource "jsonschema-specifications" do
    url "https://files.pythonhosted.org/packages/41/45/1a4ed80516f02155c51f51e8cedb3c1902296743db0bbc66608a0db2814f/jsonschema_specifications-2025.9.1-py3-none-any.whl"
    sha256 "98802fee3a11ee76ecaca44429fda8a41bff98b00a0f2838151b113f210cc6fe"
  end
  resource "Mako" do
    url "https://files.pythonhosted.org/packages/bc/b1/a0ec7a5a9db730a08daef1fdfb8090435b82465abbf758a596f0ea88727e/mako-1.3.12-py3-none-any.whl"
    sha256 "8f61569480282dbf557145ce441e4ba888be453c30989f879f0d652e39f53ea9"
  end
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/b3/81/4da04ced5a082363ecfa159c010d200ecbd959ae410c10c0264a38cac0f5/markdown_it_py-4.2.0-py3-none-any.whl"
    sha256 "9f7ebbcd14fe59494226453aed97c1070d83f8d24b6fc3a3bcf9a38092641c4a"
  end
  resource "mcp" do
    url "https://files.pythonhosted.org/packages/fd/73/42d9596facebdb533b7f0b86c1b0364ef350d1f8ba78b1052e8a58b48b65/mcp-1.27.1-py3-none-any.whl"
    sha256 "1af3c4203b329430fde7a87b4fcb6392a041f5cb851fd68fc674016ab4e7c06f"
  end
  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/b3/38/89ba8ad64ae25be8de66a6d463314cf1eb366222074cfda9ee839c56a4b4/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end
  resource "multidict" do
    url "https://files.pythonhosted.org/packages/81/08/7036c080d7117f28a4af526d794aab6a84463126db031b007717c1a6676e/multidict-6.7.1-py3-none-any.whl"
    sha256 "55d97cc6dae627efa6a6e548885712d4864b81110ac76fa4e534c03819fa4a56"
  end
  resource "opentelemetry-api" do
    url "https://files.pythonhosted.org/packages/a3/ca/9520cc1f3dfbbd03ac5903bbf55833e257bc64b1cf30fa8b0d6df374d821/opentelemetry_api-1.42.1-py3-none-any.whl"
    sha256 "51a69edacadbc03a8950ace1c4c21099cacc538820ac2c9e36277e78cebba714"
  end
  resource "opentelemetry-instrumentation" do
    url "https://files.pythonhosted.org/packages/35/a1/9314e621c143e4d82a5bf7a43c2ff7a745d31023506336857607c8c543cc/opentelemetry_instrumentation-0.63b1-py3-none-any.whl"
    sha256 "f1986716d52cc316ea5f60189098726a9071d8ecc0eee96c9ed110be08bade9c"
  end
  resource "opentelemetry-instrumentation-asgi" do
    url "https://files.pythonhosted.org/packages/57/7e/83986f27b421de04fab1e1a84e892621dac42e6432a9c66779505f4d1381/opentelemetry_instrumentation_asgi-0.63b1-py3-none-any.whl"
    sha256 "1a22453dfa965f14799b10a674b8acbcb897a8a75c79136060af54214cc7886e"
  end
  resource "opentelemetry-instrumentation-fastapi" do
    url "https://files.pythonhosted.org/packages/b1/3d/2eae63f13f36d7a8ab5bf03d06ecaf169c2069b524547f24947be6d92094/opentelemetry_instrumentation_fastapi-0.63b1-py3-none-any.whl"
    sha256 "52ee2cde9a2ac094bdd45d79f85860e03a972928a2553006071fe61d94cf7281"
  end
  resource "opentelemetry-sdk" do
    url "https://files.pythonhosted.org/packages/8f/6b/4287766cfbde577ae2272e8884abac325aeaac0d64f41c61d5b8cc595105/opentelemetry_sdk-1.42.1-py3-none-any.whl"
    sha256 "083cd4bbfaa5aa7b5a9e552430d9951219967cfb27aa61feb13a77aba1fc839d"
  end
  resource "opentelemetry-semantic-conventions" do
    url "https://files.pythonhosted.org/packages/cb/7a/7fe66f5f3682b1dd47d88cc4e11f1c6c0966b737de2d16671146e23c39a5/opentelemetry_semantic_conventions-0.63b1-py3-none-any.whl"
    sha256 "dfe5ef4dee82586b746f522b818ceb298d00b3d59f660042bd79404bff8d0682"
  end
  resource "opentelemetry-util-http" do
    url "https://files.pythonhosted.org/packages/e5/f1/34e047e8f6a3c67e5220acf1af7b9f62868c25d77791bca74457bd2180a6/opentelemetry_util_http-0.63b1-py3-none-any.whl"
    sha256 "6284194028c59cd439f8acfe388145069a6127f11dc077e1344a2094adacc3f8"
  end
  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/b2/87e62e8c3e2f4b32e5fe99e0b86d576da1312593b39f47d8ceef365e95ed/packaging-26.2-py3-none-any.whl"
    sha256 "5fc45236b9446107ff2415ce77c807cee2862cb6fac22b8a73826d0693b0980e"
  end
  resource "passlib" do
    url "https://files.pythonhosted.org/packages/3b/a4/ab6b7589382ca3df236e03faa71deac88cae040af60c071a78d254a62172/passlib-1.7.4-py2.py3-none-any.whl"
    sha256 "aa6bca462b8d8bda89c70b382f0c298a20b5560af6cbfa2dce410c0a2fb669f1"
  end
  resource "propcache" do
    url "https://files.pythonhosted.org/packages/3a/ed/1cdcab6ba3d6ab7feca11fc14f0eeea80755bb53ef4e892079f31b10a25f/propcache-0.5.2-py3-none-any.whl"
    sha256 "be1ddfcbb376e3de5d2e2db1d58d6d67463e6b4f9f040c000de8e300295465fe"
  end
  resource "proto-plus" do
    url "https://files.pythonhosted.org/packages/7c/20/b122d4626976acb81132036d2ad1bb35a1a8775fceb837ec30964622516a/proto_plus-1.28.0-py3-none-any.whl"
    sha256 "a630604310899e73c59ec302e5765c058d412b2f090b9c79c8822589f14955b8"
  end
  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/b8/ef/50433d346c56657a70d27f156c7b349ac59a068b01de4eb796e747eecc43/protobuf-7.35.0-py3-none-any.whl"
    sha256 "c13f325cf242bad135c350629eeb5d54b24228eb472fb3e2e9ebbd4c5dc20ca0"
  end
  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/5d/a0/7d793dce3fa811fe047d6ae2431c672364b462850c6235ae306c0efd025f/pyasn1-0.6.3-py3-none-any.whl"
    sha256 "a80184d120f0864a52a073acc6fc642847d0be408e7c7252f31390c0f4eadcde"
  end
  resource "pyasn1_modules" do
    url "https://files.pythonhosted.org/packages/47/8d/d529b5d697919ba8c11ad626e835d4039be708a35b0d22de83a269a6682c/pyasn1_modules-0.4.2-py3-none-any.whl"
    sha256 "29253a9207ce32b64c3ac6600edc75368f98473906e8fd1043bd6b5b1de2c14a"
  end
  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0c/c3/44f3fbbfa403ea2a7c779186dc20772604442dde72947e7d01069cbe98e3/pycparser-3.0-py3-none-any.whl"
    sha256 "b727414169a36b7d524c1c3e31839a521725078d7b2ff038656844266160a992"
  end
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/fd/7b/122376b1fd3c62c1ed9dc80c931ace4844b3c55407b6fb2d199377c9736f/pydantic-2.13.4-py3-none-any.whl"
    sha256 "45a282cde31d808236fd7ea9d919b128653c8b38b393d1c4ab335c62924d9aba"
  end
  resource "pydantic-settings" do
    url "https://files.pythonhosted.org/packages/ae/8d/f1af3832f5e6eb13ba94ee809e72b8ecb5eef226d27ee0bef7d963d943c7/pydantic_settings-2.14.1-py3-none-any.whl"
    sha256 "6e3c7edfd8277687cdc598f56e5cff0e9bfff0910a3749deaa8d4401c3a2b9de"
  end
  resource "pydub" do
    url "https://files.pythonhosted.org/packages/a6/53/d78dc063216e62fc55f6b2eebb447f6a4b0a59f55c8406376f76bf959b08/pydub-0.25.1-py2.py3-none-any.whl"
    sha256 "65617e33033874b59d87db603aa1ed450633288aefead953b30bded59cb599a6"
  end
  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/f4/7e/a72dd26f3b0f4f2bf1dd8923c85f7ceb43172af56d63c7383eb62b332364/pygments-2.20.0-py3-none-any.whl"
    sha256 "81a9e26dd42fd28a23a2d169d86d7ac03b46e2f8b59ed4698fb4785f946d0176"
  end
  resource "PyJWT" do
    url "https://files.pythonhosted.org/packages/a3/5e/ecf12fdb62546d64385c158514e9b2b671f7832108ef2ecd2020ce0af2d1/pyjwt-2.13.0-py3-none-any.whl"
    sha256 "66adcc2aff09b3f1bbd95fc1e1577df8ac8723c978552fd43304c8a290ac5728"
  end
  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/9e/44/fee070a16639d9869bb6a7e0f3a1b3946da1d66f32b9260b4d19cb90d7b2/pypdf-6.12.2-py3-none-any.whl"
    sha256 "67b2699357a1f3f4c945940ea80826349ee507c9e2577724a14b4941982c104d"
  end
  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/ec/57/56b9bcc3c9c6a792fcbaf139543cee77261f3651ca9da0c93f5c1221264b/python_dateutil-2.9.0.post0-py2.py3-none-any.whl"
    sha256 "a8b2bc7bffae282281c8140a97d3aa9c14da0b136dfe83f850eea9a5f7470427"
  end
  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/0b/d7/1959b9648791274998a9c3526f6d0ec8fd2233e4d4acce81bbae76b44b2a/python_dotenv-1.2.2-py3-none-any.whl"
    sha256 "1d8214789a24de455a8b8bd8ae6fe3c6b69a5e3d64aa8a8e5d68e694bbcb285a"
  end
  resource "python-jose" do
    url "https://files.pythonhosted.org/packages/d9/c3/0bd11992072e6a1c513b16500a5d07f91a24017c5909b02c72c62d7ad024/python_jose-3.5.0-py2.py3-none-any.whl"
    sha256 "abd1202f23d34dfad2c3d28cb8617b90acf34132c7afd60abd0b0b7d3cb55771"
  end
  resource "python-multipart" do
    url "https://files.pythonhosted.org/packages/8f/cb/769cfc37177252872a45a71f3fbdde9d51b471a3f3c14bfe95dde3407386/python_multipart-0.0.29-py3-none-any.whl"
    sha256 "2ddcc971cef266225f54f552d8fa10bcfbb1f14446caec199060daac59ff2d69"
  end
  resource "pytz" do
    url "https://files.pythonhosted.org/packages/ec/dd/96da98f892250475bdf2328112d7468abdd4acc7b902b6af23f4ed958ea0/pytz-2026.2-py2.py3-none-any.whl"
    sha256 "04156e608bee23d3792fd45c94ae47fae1036688e75032eea2e3bf0323d1f126"
  end
  resource "redis" do
    url "https://files.pythonhosted.org/packages/27/e3/b519734372d305bd547534a9f32e4ce9f98552af753dce72cf3483a0ff0b/redis-8.0.0-py3-none-any.whl"
    sha256 "c938c18338585009f0bc310f4c7e4e4b4d37639356c4ac072cedf3af570c8dc7"
  end
  resource "referencing" do
    url "https://files.pythonhosted.org/packages/2c/58/ca301544e1fa93ed4f80d724bf5b194f6e4b945841c5bfd555878eea9fcb/referencing-0.37.0-py3-none-any.whl"
    sha256 "381329a9f99628c9069361716891d34ad94af76e461dcb0335825aecc7692231"
  end
  resource "requests" do
    url "https://files.pythonhosted.org/packages/a0/f4/c67b0b3f1b9245e8d266f0f112c500d50e5b4e83cb6f3b71b6528104182a/requests-2.34.2-py3-none-any.whl"
    sha256 "2a0d60c172f83ac6ab31e4554906c0f3b3588d37b5cb939b1c061f4907e278e0"
  end
  resource "rich" do
    url "https://files.pythonhosted.org/packages/82/3b/64d4899d73f91ba49a8c18a8ff3f0ea8f1c1d75481760df8c68ef5235bf5/rich-15.0.0-py3-none-any.whl"
    sha256 "33bd4ef74232fb73fe9279a257718407f169c09b78a87ad3d296f548e27de0bb"
  end
  resource "rsa" do
    url "https://files.pythonhosted.org/packages/64/8d/0133e4eb4beed9e425d9a98ed6e081a55d195481b7632472be1af08d2f6b/rsa-4.9.1-py3-none-any.whl"
    sha256 "68635866661c6836b8d39430f97a996acbd61bfa49406748ea243539fe239762"
  end
  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/2b/58/a58fc997655386daa2e25784e30c288aa3e3819e401f77029ee4899fb55a/s3transfer-0.18.0-py3-none-any.whl"
    sha256 "239c13b09e65ad0346e1be7348b8a202dcad44ac7ea7c6eb858fc881dce739b6"
  end
  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/e0/f9/0595336914c5619e5f28a1fb793285925a8cd4b432c9da0a987836c7f822/shellingham-1.5.4-py2.py3-none-any.whl"
    sha256 "7ecfff8f2fd72616f7481040475a65b2bf8af90a56c89140852d1120324e8686"
  end
  resource "six" do
    url "https://files.pythonhosted.org/packages/b7/ce/149a00dd41f10bc29e5921b496af8b574d8413afcd5e30dfa0ed46c2cc5e/six-1.17.0-py2.py3-none-any.whl"
    sha256 "4721f391ed90541fddacab5acf947aa0d3dc7d27b2e1e8eda2be8970586c3274"
  end
  resource "SQLAlchemy" do
    url "https://files.pythonhosted.org/packages/d0/10/f7220e9b784d295d241c86ed99aeb537f92afcd469a64861f2717e9bb077/sqlalchemy-2.0.50-py3-none-any.whl"
    sha256 "92064363517a3ff8212b5a93b8c62876579d8dfd1ca5b561335f30152d884fa9"
  end
  resource "sse-starlette" do
    url "https://files.pythonhosted.org/packages/dc/67/805710444ea8cc75fbf70b920ed431a560c4bf9c57f7d5a3117213189399/sse_starlette-3.4.4-py3-none-any.whl"
    sha256 "3f4dd50d8aed2771a091f3a83000323fc3844541c16b4fe585ae2420cc6df973"
  end
  resource "starlette" do
    url "https://files.pythonhosted.org/packages/9f/85/492183764d5d01d4514be3730fdb8e228a80605783099551c51627578b5d/starlette-1.2.0-py3-none-any.whl"
    sha256 "36e0c76ac59157e75dc4b3bdeafba97fb04eaf1878045f15dbef666a6f092ed7"
  end
  resource "structlog" do
    url "https://files.pythonhosted.org/packages/a8/45/a132b9074aa18e799b891b91ad72133c98d8042c70f6240e4c5f9dabee2f/structlog-25.5.0-py3-none-any.whl"
    sha256 "a8453e9b9e636ec59bd9e79bbd4a72f025981b3ba0f5837aebf48f02f37a7f9f"
  end
  resource "tenacity" do
    url "https://files.pythonhosted.org/packages/d7/c1/eb8f9debc45d3b7918a32ab756658a0904732f75e555402972246b0b8e71/tenacity-9.1.4-py3-none-any.whl"
    sha256 "6095a360c919085f28c6527de529e76a06ad89b23659fa881ae0649b867a9d55"
  end
  resource "twilio" do
    url "https://files.pythonhosted.org/packages/ed/6b/df08b499d01ba6b9f7f42f9dd51b82aab1eb26c93602f3b89179a520494f/twilio-9.10.9-py2.py3-none-any.whl"
    sha256 "1c50bfb394b5dbc044bacab24b2e3b550bee0c08da51c4a1fa4816293303e66c"
  end
  resource "typer" do
    url "https://files.pythonhosted.org/packages/cd/cc/c6c5dea061e2740355bfeef22ac6a41751bd2f3903e83921295569bdcec4/typer-0.26.3-py3-none-any.whl"
    sha256 "e70549ec5a403ca8a0bf0802ddd9f3c6ff7a14ccbb859b01b697baa943636f33"
  end
  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/dc/9b/47798a6c91d8bdb567fe2698fe81e0c6b7cb7ef4d13da4114b41d239f65d/typing_inspection-0.4.2-py3-none-any.whl"
    sha256 "4ed1cacbdc298c220f1bd249ed5287caa16f34d44ef4e9c3d0cbad5b521545e7"
  end
  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/18/67/36e9267722cc04a6b9f15c7f3441c2363321a3ea07da7ae0c0707beb2a9c/typing_extensions-4.15.0-py3-none-any.whl"
    sha256 "f0fa19c6845758ab08074a0cfa8b7aecb71c999ca73d62883bc25cc018c4e548"
  end
  resource "tzlocal" do
    url "https://files.pythonhosted.org/packages/c2/14/e2a54fabd4f08cd7af1c07030603c3356b74da07f7cc056e600436edfa17/tzlocal-5.3.1-py3-none-any.whl"
    sha256 "eb1a66c3ef5847adf7a834f1be0800581b683b5608e74f86ecbcef8ab91bb85d"
  end
  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/7f/3e/5db95bcf282c52709639744ca2a8b149baccf648e39c8cc87553df9eae0c/urllib3-2.7.0-py3-none-any.whl"
    sha256 "9fb4c81ebbb1ce9531cce37674bbc6f1360472bc18ca9a553ede278ef7276897"
  end
  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/01/be/72532be3da7acc5fdfbccdb95215cd04f995a0886532a5b423f929cda4cc/uvicorn-0.48.0-py3-none-any.whl"
    sha256 "48097851328b87ec36117d3d575234519eb58c2b22d79666e9bbc6c49a761dad"
  end
  resource "websockets" do
    url "https://files.pythonhosted.org/packages/6f/28/258ebab549c2bf3e64d2b0217b973467394a9cea8c42f70418ca2c5d0d2e/websockets-16.0-py3-none-any.whl"
    sha256 "1637db62fad1dc833276dded54215f2c7fa46912301a24bd94d45d46a011ceec"
  end
  resource "wrapt" do
    url "https://files.pythonhosted.org/packages/ff/21/abdedb4cdf6ff41ebf01a74087740a709e2edb146490e4d9beea054b0b7a/wrapt-1.16.0-py3-none-any.whl"
    sha256 "6906c4100a8fcbf2fa735f6059214bb13b97f75b1a61777fcf6432121ef12ef1"
  end
  resource "yarl" do
    url "https://files.pythonhosted.org/packages/fd/4d/4b880086bd0d3e034d25647be1d830afc3e3f610e98c4ab3490af6b1b6d5/yarl-1.24.2-py3-none-any.whl"
    sha256 "2783d9226db8797636cd6896e4de81feed252d1db72265686c9558d97a4d94b9"
  end

  # ── Sdist fallback (compiled from source by brew at install time) ───
  resource "aliyun-python-sdk-core" do
    url "https://files.pythonhosted.org/packages/3e/09/da9f58eb38b4fdb97ba6523274fbf445ef6a06be64b433693da8307b4bec/aliyun-python-sdk-core-2.16.0.tar.gz"
    sha256 "651caad597eb39d4fad6cf85133dffe92837d53bdf62db9d8f37dab6508bb8f9"
  end
  resource "crcmod" do
    url "https://files.pythonhosted.org/packages/6b/b0/e595ce2a2527e169c3bcd6c33d2473c1918e0b7f6826a043ca1245dd4e5b/crcmod-1.7.tar.gz"
    sha256 "dc7051a0db5f2bd48665a990d3ec1cc305a466a77358ca4492826f41f283601e"
  end
  resource "oss2" do
    url "https://files.pythonhosted.org/packages/df/b5/f2cb1950dda46ac2284d6c950489fdacd0e743c2d79a347924d3cc44b86f/oss2-2.19.1.tar.gz"
    sha256 "a8ab9ee7eb99e88a7e1382edc6ea641d219d585a7e074e3776e9dec9473e59c1"
  end
  resource "tos" do
    url "https://files.pythonhosted.org/packages/60/42/079680659e1f6c20f7b837e6b13f16d4c1c389889071f49c18baea9ac2ac/tos-2.9.1.tar.gz"
    sha256 "06a5cc095d5b3f0e52b04aee8f7e60f8ddcf0c94c4408213e3485e40070d54ef"
  end
  # ─── END GENERATED RESOURCES ───

  def install
    # Why we don't use `virtualenv_install_with_resources` (the
    # Homebrew-blessed one-liner): it hardcodes `pip install
    # --no-binary :all:` which forbids wheel resources and forces
    # every dep to compile from source. With ~17 compiled deps in
    # the tree (numpy / cryptography / pydantic-core / asyncpg /
    # aiohttp / hiredis / etc.) that's 20-40 min on M-series and
    # can hard-fail if Homebrew didn't pre-install Fortran/BLAS.
    #
    # Custom path: create the venv, then pip-install each resource
    # individually. Wheel resources go in via `pip install <whl-file>`;
    # sdist resources go in via the standard stage-then-`pip install .`.
    # Build-isolation stays ON so sdists that need setuptools /
    # hatchling pick up their build backend from PyPI at install
    # time (default pip behaviour, no flag needed).
    # `opt_libexec/bin/python` (no version suffix) is the PEP-668-
    # friendly framework wrapper for python@3.12 — the one Homebrew's
    # own Virtualenv helper uses internally. Using the explicit path
    # (rather than the formula name "python@3.12" or even the
    # executable name "python3.12") avoids any PATH-resolution
    # surprise during `brew install`: the v0.2.3 form
    # `virtualenv_create(libexec, "python@3.12")` blew up because
    # brew tried to invoke `python@3.12` as a binary — that's a
    # FORMULA name, not an executable name.
    parent_python = Formula["python@3.12"].opt_libexec/"bin/python"
    venv_python = libexec/"bin/python"

    # virtualenv_create populates libexec/ with the venv. We don't keep
    # a handle on the returned Virtualenv object because we install
    # resources directly via pip below — its helper methods would
    # re-introduce --no-binary :all:.
    virtualenv_create(libexec, parent_python.to_s)

    install_into_venv = lambda do |target|
      system parent_python, "-m", "pip",
             "--python=#{venv_python}",
             "install",
             "--no-deps",
             "--disable-pip-version-check",
             target.to_s
    end

    # Wheels need a sibling-dir to copy into. Homebrew's cache stores
    # downloads as `<sha>--<original-filename>`, and pip's wheel
    # filename parser refuses anything with that prefix
    # ("wrong number of parts" — pip expects exactly
    # `name-version-python-abi-platform.whl`). We copy each cached
    # wheel to a canonical-named file under buildpath/_wheels/ and
    # pip-install from there.
    wheel_stage = buildpath/"_wheels"
    wheel_stage.mkpath

    resources.each do |r|
      if r.url.end_with?(".whl")
        r.fetch
        whl = wheel_stage/File.basename(r.url)
        cp r.cached_download, whl
        install_into_venv.call(whl)
      else
        # Sdist: standard stage and install. The stage block extracts
        # the .tar.gz into a temp dir and cd's there before yielding.
        r.stage do
          install_into_venv.call(Pathname.pwd)
        end
      end
    end

    # openvox-core itself comes from the formula's main `url`
    # (an sdist). buildpath is the unpacked tree root.
    install_into_venv.call(buildpath)

    # Expose the bin shim on PATH.
    bin.install_symlink Dir[libexec/"bin/openvox"]
  end

  test do
    # Sanity check after install — verifies the bin works without
    # crashing. We don't start the server here because that would
    # require network + open a port on the build machine.
    assert_match version.to_s, shell_output("#{bin}/openvox version")
    assert_match "openvox", shell_output("#{bin}/openvox --help")
  end
end
