class BshareOneController < ApplicationController
  def index
  end

  def bshare_one
    @bsyncCustomizeEmbed = bsyncCustomizeEmbed
    @publisherStatisticsEmbed = publisherStatisticsEmbed
    @websiteCustomizeEmbed = websiteCustomizeEmbed
    @bsyncCustomizeManagerEmbed = bsyncCustomizeManagerEmbed
  end

  def bsyncCustomizeEmbed
    # http://www.bshare.cn/bsyncCustomizeEmbed? uuid=<publisher uuid>&email=<useremail>&ts=<timestamp>&sig=<signature>
    base_url = "#{website_base_url}/bsyncCustomizeEmbed"
    params = {"uuid" => uuid, "email" => 'test@magic.com', "ts" => Time.now.to_i * 1000}

    params["sig"] = sign(params, secret)
    return generate_url(base_url, params)
  end

  def publisherStatisticsEmbed
    base_url = "#{website_base_url}/publisherStatisticsEmbed"
    params = {"uuid" => uuid, "ts" => Time.now.to_i * 1000}

    params["sig"] = sign(params, secret)
    return generate_url(base_url, params)
  end

  def websiteCustomizeEmbed
    "#{website_base_url}/websiteCustomizeEmbed?email=#{bshare_user}&password=#{bshare_password}"
  end

  def bsyncCustomizeManagerEmbed
    "#{website_base_url}/bsyncCustomizeManagerEmbed?email=#{bshare_user}&password=#{bshare_password}"
  end

end
