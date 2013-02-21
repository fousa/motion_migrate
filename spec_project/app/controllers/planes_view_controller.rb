class PlanesViewController < UITableViewController
  CELL_IDENTIFIER = "CELL"

  def viewDidLoad
    @planes = Plane.MR_findAll

    self.tableView.registerClass(UITableViewCell, forCellReuseIdentifier:CELL_IDENTIFIER)
  end

  def viewWillAppear(animated)
    self.title = "Planes"
  end

  def numberOfSectionsInTableView(table_view)
    @planes.count
  end

  def tableView(table_view, titleForHeaderInSection:section)
    plane_for_section(section).name
  end

  def tableView(table_view, numberOfRowsInSection:section)
    pilots_for_section(section).count
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = table_view.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.textLabel.text = pilot_for_index_path(index_path).name
    cell
  end

  protected

  def plane_for_section section
    @planes[section]
  end

  def pilots_for_section section
    plane_for_section(section).flown_by_pilots.allObjects
  end

  def pilot_for_index_path index_path
    pilots_for_section(index_path.section)[index_path.row]
  end
end