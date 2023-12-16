import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faInstagram,
  faFacebook,
  faLinkedin,
} from "@fortawesome/free-brands-svg-icons";
import { faPaperPlane, faEnvelope } from "@fortawesome/free-solid-svg-icons";
import { Link } from "react-router-dom";
function Footer() {
  return (
    <>
      <div
        className="info-footer flex justify-around items-center text-white sticky"
        style={{ height: "50px", backgroundColor: "#53382c" }}
      >
        <div>
          <Link>
            <FontAwesomeIcon
              className="h-6 m-1 hover:bg-amber-300"
              icon={faInstagram}
            />
          </Link>
          <Link>
            <FontAwesomeIcon
              className="h-6 m-1 hover:bg-amber-300"
              icon={faFacebook}
            />
          </Link>
          <Link>
            <FontAwesomeIcon
              className="h-6 m-1 hover:bg-amber-300"
              icon={faLinkedin}
            />
          </Link>
        </div>
        <p>© 2018 Highlands Coffee. All rights reserved</p>
        <Link className="flex items-center hover:text-amber-300">
          <FontAwesomeIcon icon={faPaperPlane} className="m-2" />
          <p>Đăng ký để nhận bản tin</p>
        </Link>
        <div className="flex items-center">
          <FontAwesomeIcon icon={faEnvelope} className="m-2" />
          <p>customerservice@highlandscoffee.com.vn</p>
        </div>
      </div>
    </>
  );
}

export default Footer;
