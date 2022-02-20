import React, { useEffect } from "react";
import BootstrapTable from "react-bootstrap-table-next";
import {
  Card,
  CardBody,
  // CardHeader,
  // CardTitle,
  Col,
  Container,
  Row,
} from "reactstrap";

import paginationFactory from "react-bootstrap-table2-paginator";

import { connect } from "react-redux";
import { getListGroupAction } from "../../redux/actions/groupAction";
import GroupApi from "../../api/GroupApi.js";
import {
  selectListGroup,
  selectPage,
  selectSize,
  selectTotalSize,
} from "../../redux/selector/groupSelecter.js";
import CardHeader from "reactstrap/lib/CardHeader";
import CardTitle from "reactstrap/lib/CardTitle";
const tableColumns = [
  {
    dataField: "id",
    text: "Mã phòng ban",
    sort: true,
  },
  {
    dataField: "name",
    text: "Tên phòng ban",
    sort: true,
  },
  {
    dataField: "description",
    text: "Mô tả phòng ban",
    sort: true,
  },
  {
    dataField: "status",
    text: "Trạng thái phòng ban",
    sort: true,
  },
  {
    dataField: "acction",
    text: "Hành động",
    sort: true,
  },
];

const Group = (props) => {
  // set để
  const getListGroup = props.getListGroupAction;
  const size = props.size;
  // không để props trong useEffect , gán props cho biến ngoài rồi cho effect phụ thuộc vào nó
  useEffect(() => {
    // lúc mới vào gọi api truyền vào page= 0 và size lấy từ redux (=5)
    const getAllGroup = async () => {
      const result = await GroupApi.getAll(0, size);
      // lấy data
      const groups = result.content;
      console.log(groups);
      //lấy total element
      const totalSize = result.totalElements;
      // ném action cho redux qua props.getListGroupAction = getListGroup truyền vào data= groups, page = 1 ,totalSize = totalElements
      getListGroup(groups, 1, totalSize);
    };
    getAllGroup();
  }, [getListGroup, size]);
  // khi nhấn vào chuyển trang , tức table thay đổi, ta có hàm onTableChange
  // giả sử lúc này page đang bằng 1 (trên màn hình ) , nhưng thực ra lúc gọi api thì phải page 0 nên ta truyền vào api page -1
  // sizePerPage không cần dùng vì có thể fix cứng bên redux
  const handleTableChange = async (type, { page, sizePerPage }) => {
    const result = await GroupApi.getAll(page - 1, size);
    //tại đây gọi lại api và lấy ra trang mới hiển thị lên
    const groups = result.content;
    const totalSize = result.totalElements;
    getListGroup(groups, page, totalSize);
  };
  return (
    <Container fluid className="p-0">
      <h1 className="h3 mb-3">Management</h1>

      <Row>
        <Col>
          <Card>
            <CardHeader>
              <CardTitle tag="h5" className="mb-0">
                Department Management
              </CardTitle>
            </CardHeader>
            <CardBody>
              <BootstrapTable
                remote
                keyField="name"
                data={props.groups}
                columns={tableColumns}
                //css
                bootstrap4
                striped={true}
                hover={true}
                bordered={true}
                //
                pagination={paginationFactory({
                  page: props.page,
                  sizePerPage: props.size,
                  totalSize: props.totalSize,
                  hideSizePerPage: true,
                })}
                onTableChange={handleTableChange}
              />
            </CardBody>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};
const mapGlobalStateToProps = (state) => {
  return {
    groups: selectListGroup(state),
    page: selectPage(state),
    size: selectSize(state),
    totalSize: selectTotalSize(state),
  };
};
export default connect(mapGlobalStateToProps, { getListGroupAction })(Group);
