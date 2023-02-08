import { ReactElement } from "react";
import cx from "classnames";
import { Row } from "antd";

import "./index.scss";

interface OwnProps {
  logoSrc?: string;
  sideImgSrc?: string;
  alignCenter?: boolean;
  theme?: "light" | "dark";
  children: ReactElement;
  className?: string;
}

const SideImageLayout = ({
  logoSrc,
  sideImgSrc,
  alignCenter = true,
  theme = "dark",
  children,
  className = " ",
}: OwnProps) => (
  <div className={cx("sideImagePageContainer", className)}>
    {logoSrc && (
      <a href="https://portal.includedcc.org">
        <img className={"logoImage"} src={logoSrc} alt="Include Logo Logo" />
      </a>
    )}
    <Row className={"contentWrapper"}>
      <div
        className={"sideImageContainer"}
        style={{
          backgroundImage: `url(${sideImgSrc})`,
          backgroundPosition: "center",
          backgroundSize: "cover",
        }}
      />
      <Row
        className={cx(
          "pageContent",
          alignCenter && "alignCenter",
          theme === "light" ? "light" : "dark"
        )}
      >
        {children}
      </Row>
    </Row>
  </div>
);

export default SideImageLayout;
