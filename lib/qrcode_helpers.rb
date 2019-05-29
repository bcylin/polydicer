require 'rqrcode'

module QrcodeHelpers
  def generate_qrcode(url)
    qrcode = RQRCode::QRCode.new(url)
    qrcode.as_svg(
      offset: 0,
      color: '555',
      shape_rendering: 'crispEdges',
      module_size: 6
    )
  end
end
